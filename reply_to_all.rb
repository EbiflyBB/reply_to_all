# -*- coding: utf-8 -*-

Plugin.create :reply_to_all do
  command(:reply_to_all,
          name: 'これに含まれるID全部を巻き込んで返信',
          description: "全員に返信とも言うかもしれない",
          condition: lambda{ |opt| true },
          visible: true,
          icon: Skin.get("reply.png"),
          role: :timeline) do |opt|
    ids = opt.messages.to_s.scan(%r<@[a-zA-Z0-9\_]+>)
    rep_to = ids.uniq.join(' ') + ' '
    rep_to.slice!("@#{Service.primary.idname} ")

    opt.widget.create_postbox(to: opt.messages,
                              header: "#{rep_to}",
                              use_blind_footer: !UserConfig[:footer_exclude_reply])
  end
end
