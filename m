Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2FE15F941
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2020 23:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgBNWKG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Feb 2020 17:10:06 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38271 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgBNWKG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Feb 2020 17:10:06 -0500
Received: by mail-ot1-f67.google.com with SMTP id z9so10622311oth.5
        for <cgroups@vger.kernel.org>; Fri, 14 Feb 2020 14:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HmeItrbeT8lCL/ZNYZZGsWCvwnm5kkr2rqBl2D7d+yI=;
        b=SiYXIwQptkSpHrfTYtRDvD4avqyR+d6M8LFcKnPpP1XrM0ZgDF+KgR49iUDDq0VDqn
         3aR84o+eOpZdrOlUguxCAO59W6jWSO1aHzNZTOYmVq/K/dlBaTFwaeP1fQN9kW91XmtL
         51AJnrVQh08gdVJVxkk7bsDJXcfOgYWJu7H35D+Ag7f4JndRnTa0KNE1VIVY29E45G93
         10NdVDTcJhS7A6y+WfYA988ZsEWuK2mQEQzKJNfwgCbZfz3BV61ZEzjPUkbpckOJZp/v
         x0xX9pcZy07Ar7+9w/40Z8y1OiYKlLNgc30Y6QRXhvjyE4IGOPx0pnkNKmokZXVPpkWK
         QpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HmeItrbeT8lCL/ZNYZZGsWCvwnm5kkr2rqBl2D7d+yI=;
        b=eYAaD2auEfalwkmoKBPazKIry3L5pKVdxDQHpKOHrrX3DSPl1bnT/kpqq04db2utjO
         b2qkhjOvNk8NCg12Qyu6fbz0SM0pv/YjoAq0smvAjnEmdAAeOFPiBqw284pLOEBiL6tI
         LhA/Q3t22CaJAHMm+Au/kMnyKw+yYrWuHOc3GsmyQRsB7UJYyyGQk938svmW1AJguqz1
         Z6H6+Nc7dWlJuWyHagL1cBk/O8JSSfJivZwPKKWXgtZ8HBCxo63/tfZNrT1GQuNjEtlh
         nTS8nU40H8lBASeHZvG5iIcdhkX1q5A3DlVMk/JOKKjPhDBNCM2cm4R1OZN5Wgn56+99
         hlJA==
X-Gm-Message-State: APjAAAXxbDeNA6HUKTNQgSr2AdcIr7QxgvodifHBmDUwMjNNRrGseTe/
        P+yOenmvqD3oLohPgOSPoR113isd5SLRRwdYQ+36Qg==
X-Google-Smtp-Source: APXvYqwHHGHT9W38L0gZh59f4mWQF4TFjGIJ41O3DrdoZPjp8dHjHCXcJJe6QoKJxO+tZCWSpeKhIhAHbgUDHyJ1HhI=
X-Received: by 2002:a05:6830:11:: with SMTP id c17mr3919941otp.360.1581718205007;
 Fri, 14 Feb 2020 14:10:05 -0800 (PST)
MIME-Version: 1.0
References: <20200214071233.100682-1-shakeelb@google.com> <20200214214730.GA99109@carbon.DHCP.thefacebook.com>
 <CALvZod4sum32d_ujFrRFhBVrE6TmhHrwWu=LPX+mG0urD4w80w@mail.gmail.com>
In-Reply-To: <CALvZod4sum32d_ujFrRFhBVrE6TmhHrwWu=LPX+mG0urD4w80w@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 14 Feb 2020 14:09:54 -0800
Message-ID: <CALvZod7jDBX7gZzhpc728tE3AneJEqC1WYgVY3K2LpbByNzYLA@mail.gmail.com>
Subject: Re: [PATCH] memcg: net: do not associate sock with unrelated memcg
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Eric Dumazet <edumazet@google.com>,
        Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 14, 2020 at 1:52 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Fri, Feb 14, 2020 at 1:47 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > Hello, Shakeel!
> >
> > On Thu, Feb 13, 2020 at 11:12:33PM -0800, Shakeel Butt wrote:
> > > We are testing network memory accounting in our setup and noticed
> > > inconsistent network memory usage and often unrelated memcgs network
> > > usage correlates with testing workload. On further inspection, it seems
> > > like mem_cgroup_sk_alloc() is broken in irq context specially for
> > > cgroup v1.
> >
> > A great catch!
> >
> > >
> > > mem_cgroup_sk_alloc() can be called in irq context and kind
> > > of assumes that it can only happen from sk_clone_lock() and the source
> > > sock object has already associated memcg. However in cgroup v1, where
> > > network memory accounting is opt-in, the source sock can be not
> > > associated with any memcg and the new cloned sock can get associated
> > > with unrelated interrupted memcg.
> > >
> > > Cgroup v2 can also suffer if the source sock object was created by
> > > process in the root memcg or if sk_alloc() is called in irq context.
> >
> > Do you mind sharing a call trace?
> >
>
> Sure, see below. I added a dump_stack() in mem_cgroup_sk_alloc().
>
> [  647.255327] CPU: 68 PID: 15859 Comm: ssh Tainted: G           O
>  5.6.0-smp-DEV #1
> [  647.255328] Hardware name: ...
> [  647.255328] Call Trace:
> [  647.255329]  <IRQ>
> [  647.255333]  dump_stack+0x57/0x75
> [  647.255336]  mem_cgroup_sk_alloc+0xe9/0xf0
> [  647.255337]  sk_clone_lock+0x2a7/0x420
> [  647.255339]  inet_csk_clone_lock+0x1b/0x110
> [  647.255340]  tcp_create_openreq_child+0x23/0x3b0
> [  647.255342]  tcp_v6_syn_recv_sock+0x88/0x730
> [  647.255343]  tcp_check_req+0x429/0x560
> [  647.255345]  tcp_v6_rcv+0x72d/0xa40
> [  647.255347]  ip6_protocol_deliver_rcu+0xc9/0x400
> [  647.255348]  ip6_input+0x44/0xd0
> [  647.255349]  ? ip6_protocol_deliver_rcu+0x400/0x400
> [  647.255350]  ip6_rcv_finish+0x71/0x80
> [  647.255351]  ipv6_rcv+0x5b/0xe0
> [  647.255352]  ? ip6_sublist_rcv+0x2e0/0x2e0
> [  647.255354]  process_backlog+0x108/0x1e0
> [  647.255355]  net_rx_action+0x26b/0x460
> [  647.255357]  __do_softirq+0x104/0x2a6
> [  647.255358]  do_softirq_own_stack+0x2a/0x40
> [  647.255359]  </IRQ>
> [  647.255361]  do_softirq.part.19+0x40/0x50
> [  647.255362]  __local_bh_enable_ip+0x51/0x60
> [  647.255363]  ip6_finish_output2+0x23d/0x520
> [  647.255365]  ? ip6table_mangle_hook+0x55/0x160
> [  647.255366]  __ip6_finish_output+0xa1/0x100
> [  647.255367]  ip6_finish_output+0x30/0xd0
> [  647.255368]  ip6_output+0x73/0x120
> [  647.255369]  ? __ip6_finish_output+0x100/0x100
> [  647.255370]  ip6_xmit+0x2e3/0x600
> [  647.255372]  ? ipv6_anycast_cleanup+0x50/0x50
> [  647.255373]  ? inet6_csk_route_socket+0x136/0x1e0
> [  647.255374]  ? skb_free_head+0x1e/0x30
> [  647.255375]  inet6_csk_xmit+0x95/0xf0
> [  647.255377]  __tcp_transmit_skb+0x5b4/0xb20
> [  647.255378]  __tcp_send_ack.part.60+0xa3/0x110
> [  647.255379]  tcp_send_ack+0x1d/0x20
> [  647.255380]  tcp_rcv_state_process+0xe64/0xe80
> [  647.255381]  ? tcp_v6_connect+0x5d1/0x5f0
> [  647.255383]  tcp_v6_do_rcv+0x1b1/0x3f0
> [  647.255384]  ? tcp_v6_do_rcv+0x1b1/0x3f0
> [  647.255385]  __release_sock+0x7f/0xd0
> [  647.255386]  release_sock+0x30/0xa0
> [  647.255388]  __inet_stream_connect+0x1c3/0x3b0
> [  647.255390]  ? prepare_to_wait+0xb0/0xb0
> [  647.255391]  inet_stream_connect+0x3b/0x60
> [  647.255394]  __sys_connect+0x101/0x120
> [  647.255395]  ? __sys_getsockopt+0x11b/0x140
> [  647.255397]  __x64_sys_connect+0x1a/0x20
> [  647.255398]  do_syscall_64+0x51/0x200
> [  647.255399]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  647.255401] RIP: 0033:0x7f45464fcd50
>
> > Also, shouldn't cgroup_sk_alloc() be changed in a similar way?
> >
>
> I will check cgroup_sk_alloc() too.
>

Yes, cgroup_sk_alloc() should be changed similarly too.
