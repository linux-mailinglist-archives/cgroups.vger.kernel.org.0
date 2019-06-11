Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B96723D5F4
	for <lists+cgroups@lfdr.de>; Tue, 11 Jun 2019 20:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404753AbfFKS5w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jun 2019 14:57:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44066 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404245AbfFKS5w (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jun 2019 14:57:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so7456290pgp.11
        for <cgroups@vger.kernel.org>; Tue, 11 Jun 2019 11:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PvZOO6SlbBl6sW8KnxeVjLzBojASciU8drnfnIurJCc=;
        b=SwFC4U/Zp8tFk3Tqh/SCVKLFThHBrcmG2nZWPUrPjPkegyO8eUtkmAdbmYGJDPb+69
         hALVV6ry/jph3KSWS3xE3IUE5jWcUqWrf3B2FvHdz8qAjFWeNdHn8YowWRxFH1Kc2rHp
         mslUfK3BICyRbSHn8GbZHLu84BITnyU6GdgkTEWKtR/3r51Bm1i23ZiYybqNZZngvDHn
         XdlZcpe/Pd0l6AVAzU5HqNR3ilieoV4Othd8IV1c6Szhrj1OySxkFmBdmRa4EfShq772
         q3lM5JH1PnwHSB8sPVIP+M/JvarQdfUiXildWCqOyCmRGQ2vUwn4hZluKS8uqNeaYVrL
         iLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=PvZOO6SlbBl6sW8KnxeVjLzBojASciU8drnfnIurJCc=;
        b=dSx0nZixDuz88iLxp4MwAphryJfHPWW7I8nThARDbRmtU/2K3Jzb6PtguBkVtK+c5N
         GyV1Yp6ju9C/AINY+k3NAZlhXVK+/QwgOSgBTZ7koEeO6jOgqtDWjWspizUID9wmMqBF
         6204MadpnufausIQpuQPoVadeeCY9msNvv7xNmvy1y4Waq4uE9LEJlNefHb7jNPUDVw1
         SyUl+650q+gpusmNg24uIPy8IOeMxvG0icVDiaePNMYmDp92rgULTQVJbKQcYEZamc9i
         TJOPt80M1RxO9Ko5CZCG/XcoYpwGQEVGlsU3vss3BectmMkiMbg7+r0QC3LorQHqb5wN
         EuBA==
X-Gm-Message-State: APjAAAUaS/ow16JGK4fL432XydejBaBhDLzLMkIjiBKwDXaWDrixa+Yd
        Uxh7BruIEtaqnuoCs/+w+hY=
X-Google-Smtp-Source: APXvYqy/5+dVXalJDmH9t6CoJcAC6PcnQaBGODeQYN4PZ3BdjshoMX7bNLjCpoy219xGzDsx4GRPig==
X-Received: by 2002:a65:4086:: with SMTP id t6mr20974572pgp.155.1560279471703;
        Tue, 11 Jun 2019 11:57:51 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:1677])
        by smtp.gmail.com with ESMTPSA id o13sm23016pje.28.2019.06.11.11.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 11:57:50 -0700 (PDT)
Date:   Tue, 11 Jun 2019 11:57:42 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Topi Miettinen <toiwoton@gmail.com>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org,
        security@debian.org, security@kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 3/3 cgroup/for-5.2-fixes] cgroup: Include dying leaders
 with live threads in PROCS iterations
Message-ID: <20190611185742.GH3341036@devbig004.ftw2.facebook.com>
References: <87blznagrl.fsf@xmission.com>
 <1956727d-1ee8-92af-1e00-66ae4921b075@gmail.com>
 <87zhn6923n.fsf@xmission.com>
 <e407a8e7-7780-f08f-320a-a0f2c954d253@gmail.com>
 <20190529003601.GN374014@devbig004.ftw2.facebook.com>
 <e45d974b-5eff-f781-291f-ddf5e9679e4c@gmail.com>
 <20190530183556.GR374014@devbig004.ftw2.facebook.com>
 <20190530183637.GS374014@devbig004.ftw2.facebook.com>
 <20190530183700.GT374014@devbig004.ftw2.facebook.com>
 <20190607170952.GE30727@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190607170952.GE30727@blackbody.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Michal.

On Fri, Jun 07, 2019 at 07:09:53PM +0200, Michal Koutný wrote:
> Wouldn't it make more sense to call
> 	css_set_move_task(tsk, cset, NULL, false);
> in cgroup_release instead of cgroup_exit then?
>
> css_set_move_task triggers the cgroup emptiness notification so if we
> list group leaders with running siblings as members of the cgroup (IMO
> correct), is it consistent to deliver the (un)populated event
> that early?
> By moving to cgroup_release we would also make this notification
> analogous to SIGCHLD delivery.

So, the current behavior is mostly historical and I don't think this
is a better behavior.  That said, I'm not sure about the cost benefit
ratio of changing the behavior at this point given how long the code
has been this way.  Another aspect is that it'd expose zombie tasks
and possibly migrations of them to each controller.

Thanks.

-- 
tejun
