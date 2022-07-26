Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C01581AA3
	for <lists+cgroups@lfdr.de>; Tue, 26 Jul 2022 22:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbiGZUBJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Jul 2022 16:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239511AbiGZUBI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Jul 2022 16:01:08 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EC6326ED;
        Tue, 26 Jul 2022 13:01:07 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id p1so5795280plr.11;
        Tue, 26 Jul 2022 13:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yv3KulA6SXC2d8qM1b4VH3vnSrCIQuVcceAGzMpyLq8=;
        b=WbRPhU62l5iVyr4AcFYCotiJR0a3zh4yuvzp5Pd70CDeFQKGfrxYJbWXPGYF6U77pc
         h5Xmz9Dx5kcvff7vnNyIjlyxmGcdBUEi/f/SeyWO3qqTx+jnReUp57Sg5fkReqxh+3Q+
         sUUp3ZGpYVjB27BiFwPry4pwxt2+Jdo28gB3WuTk0BYAtVge24qHNPNGAPZeKZZNuOez
         xorfG80VYE2snEUfiEvGCLZHBc20QLBe0gjtW3e7PuYRDH9f62HUnO2qsNdTIYT8igpI
         2BvIX5HHGwgInkdtHjsrpWV+HMu4nzq3YnxNOarw1Mbmh9sBvPPd2gr54eaPXvm5qXCR
         tPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=yv3KulA6SXC2d8qM1b4VH3vnSrCIQuVcceAGzMpyLq8=;
        b=rTExuknG5sQP0NcuZPRRipl0KQhntoRc0WLS1yvva7c84ASEU02tT3kORODN0A/VQQ
         R776swRTemGeCw/Rr4SttFxn/PVR2Mh1SjDodEFiLmiG2QgzZc4sX7bJsWNZ+iFunMj0
         kOwGUtHbB8fCmZYWDxGVDEsKJpOZJkNcyh4pxOGYqx7JgMiilBpyqkxLVgUltW5EB5xu
         wQc6bDTLgkRXDceKKKHwLjUOEnb9JojD11k5UHt6UgZTkF/zUjMmR1E6eo68whUWEEuU
         wrqsnNa/fB/ueX3bhbaRwsfbcpnF+DDFpof4DyiMOs/S5B5yq12J8MSCFe6ZSJFtms1C
         tYHQ==
X-Gm-Message-State: AJIora8we/vIrnzN1CfO5fCWSlvyM1eD9ufDMVT/kqM+O24E08rZM8WL
        UOBpdSduUrwqBTZI6pX09n0=
X-Google-Smtp-Source: AGRyM1tnb5AxLOGD2jbQ8XPz7xI0xp2eAgfdLGv/eQNKyE3usSewXXjOp9DnRkmXq35ENuJsApF8lA==
X-Received: by 2002:a17:90b:2c02:b0:1f2:fdb2:dc23 with SMTP id rv2-20020a17090b2c0200b001f2fdb2dc23mr744968pjb.182.1658865666856;
        Tue, 26 Jul 2022 13:01:06 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:370d])
        by smtp.gmail.com with ESMTPSA id e15-20020a17090a280f00b001f2f301fd6bsm1840795pjd.38.2022.07.26.13.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 13:01:06 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 26 Jul 2022 10:01:04 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 2/3 cgroup/for-5.20] cgroup: Add "no" prefixed mount
 options
Message-ID: <YuBIACfZDk72yjI3@slm.duckdns.org>
References: <YtDvN0wJ6CKaEPN8@slm.duckdns.org>
 <YtDvU4jRPSsarcNp@slm.duckdns.org>
 <20220726143246.GA23794@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220726143246.GA23794@blackbody.suse.cz>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Jul 26, 2022 at 04:32:46PM +0200, Michal Koutný wrote:
> On Thu, Jul 14, 2022 at 06:38:43PM -1000, Tejun Heo <tj@kernel.org> wrote:
> > We allow modifying these mount options via remount. Let's add "no" prefixed
> > variants so that they can be turned off too.
> 
> They can be turned off:
> 
> > // on v5.19-rc?
> > :~ # grep cg /proc/mounts
> > cgroup2 /sys/fs/cgroup cgroup2 rw,nosuid,nodev,noexec,relatime,nsdelegate 0 0
> > :~ # mount -t cgroup2 cgroup2 /sys/fs/cgroup/ -oremount
> > :~ # grep cg /proc/mounts
> > cgroup2 /sys/fs/cgroup cgroup2 rw,relatime 0 0
> 
> The mount(2) says about remounting:
> > The  mountflags  and  data  arguments should match the values used in
> > the original mount() call, except for those parameters that are being
> > deliberately changed.
>
> Or is this a provision for the fsconfig(2) API?

It's just me not knowing how these things work. I just looked at other real
filesystems and copied.

> > +	fsparam_flag("memory_nolocalevents",	Opt_memory_nolocalevents),
> > +	fsparam_flag("memory_norecursiveprot",	Opt_memory_norecursiveprot),
> 
> These are not 'no' prefixes of the option :-)

Oh, I tried that first but nomemory_recursiveprot looked really weird. The
thing is that the underbar is added to separate the subsystem from the
actual option and we're now prepending no to the subsystem part of the name.
I'm not super attached to the current names tho.

> I.e. it seem more consistent to prefix whole boolean option name (in
> accordance with other FS options but I know limited subset of them).
> In the end, this should be handled generically for boolean options in
> the VFS and not via custom options.
> 
> Also, this allows both
> 	'nsdelegate,nonsdelegate'
> and
> 	'nonsdelegate,nsdelegate'
> (nsdelegate is just an example) where the 'no' always overrides being a
> hidden implementation detail.
> 
> I find this patch a bit weird.

It is a bit weird. Lemme play a bit with turning off the options and I'll
remove the no options if they can be turned off without explicitly
specifying them.

Thanks.

-- 
tejun
