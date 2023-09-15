Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37737A24DB
	for <lists+cgroups@lfdr.de>; Fri, 15 Sep 2023 19:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbjIORd2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Sep 2023 13:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbjIORc7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Sep 2023 13:32:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083F73ABD;
        Fri, 15 Sep 2023 10:31:47 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c06f6f98c0so21475685ad.3;
        Fri, 15 Sep 2023 10:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694799106; x=1695403906; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uh+Svyu69yjI7IZ0hILShgFArwlpiuOCby9tFGyVqR8=;
        b=MyFJanD/JyG6CZw1jd7qaQ6kwaizla4Q1YJOLrJ6320U+9vxRF5sj8YiZLWqFEyWeX
         7zZnvN9Z35bnK6yT9iFomEmDvGhk8jExSns6B0jVI25OMfx/wLJJt3yl8UzrPmg2k/MD
         tzjzGv5tcI0GxlDU/F0h/ZNaFjHc/qi39FarDgaXhvO1McQimWDlSZR13cDfbkhv+T1p
         qMI2bi4Lo6g3Zymgy8+llGsv/BpT//gC8ph66SnX+AMyMXlossDaTJ/4CTn7MvOY4rb2
         4E4vqCHD32pyBH47F1pjGtdZeMorsRMB9a9kwU3CD8evncSd4X78k92UYjKQo46wGmVg
         S5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694799106; x=1695403906;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uh+Svyu69yjI7IZ0hILShgFArwlpiuOCby9tFGyVqR8=;
        b=Az51IBMRgaldvXHrOTosUIu+ZsaE8jTrrQ5QCBzg8eIMBaTPCOGu0un4wykFaCXQus
         EJN+hhPjl/g0bYskFPxcX0PFGcbxirCkBOcNdNgOG8lIUhh8BdBpT59kQZBFKZ+/txeq
         ceBojv/LbX+32iZCR14VRG6HO8q3xKobVM1HMlCoS0LCvGeqNt83fQPLYEwOGamE1oDs
         xLe223m9LLcBDebFoCqtTqd7cVODu6ICSj6eDLyqkheht8JuUrjOfTpE+w82e44isx0w
         Dj6k0/j11FOgKSYsTtHdRdGq2RNDvlXhNzrDNT3TuTI6V0wrx87wYm7eDYAMEZkW9dG0
         g9Hw==
X-Gm-Message-State: AOJu0YwmTOFEbjZJxBG4I5I+lUb5pyIW9JOoCvpWyJKKIvVDiFWjsSOb
        N2NzaO1paF3Tqsinp02U/D0=
X-Google-Smtp-Source: AGHT+IEMD0ybfNq7bcxql1mt92ZWWVw00Hcg32Yehr09pM5ZJgT9yOw9K2SImgB8Ie0w1CsooHbV3A==
X-Received: by 2002:a17:902:6949:b0:1bb:9b29:20d9 with SMTP id k9-20020a170902694900b001bb9b2920d9mr2221472plt.20.1694799105825;
        Fri, 15 Sep 2023 10:31:45 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id ix11-20020a170902f80b00b001c3a7fbf96fsm14336plb.216.2023.09.15.10.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 10:31:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 15 Sep 2023 07:31:43 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH bpf-next 0/5] bpf, cgroup: Enable cgroup_array map on
 cgroup1
Message-ID: <ZQSU_0RhpVw-Y0v2@mtj.duckdns.org>
References: <20230903142800.3870-1-laoar.shao@gmail.com>
 <qv2xdcsvb4brjsc7qx6ncxrudwusogdo4itzv4bx2perfjymwl@in7zaeymjiie>
 <CALOAHbB-PF1LjSAxoCdePN6Va4D+ufkeDmq8s3b0AGtfX5E-cQ@mail.gmail.com>
 <CAADnVQL+6PsRbNMo=8kJpgw1OTbdLG9epsup0q7La5Ffqj6g6A@mail.gmail.com>
 <CALOAHbBhOL9w+rnh_xkgZZBhxMpbrmLZWhm1X+ZeDLfxxt8Nrw@mail.gmail.com>
 <ZP93gUwf_nLzDvM5@mtj.duckdns.org>
 <CALOAHbC=yxSoBR=vok2295ejDOEYQK2C8LRjDLGRruhq-rDjOQ@mail.gmail.com>
 <jikppfidbxyqpsswzamsqwcj4gy4ppysvcskrw4pa2ndajtul7@pns7byug3yez>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jikppfidbxyqpsswzamsqwcj4gy4ppysvcskrw4pa2ndajtul7@pns7byug3yez>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 15, 2023 at 07:01:28PM +0200, Michal Koutný wrote:
> Hello.
> 
> On Tue, Sep 12, 2023 at 11:30:32AM +0800, Yafang Shao <laoar.shao@gmail.com> wrote:
> > With the above changes, I think it can meet most use cases with BPF on cgroup1.
> > What do you think ?
> 
> I think the presented use case of LSM hooks is better served by the
> default hierarchy (see also [1]).
> Relying on a chosen subsys v1 hierarchy is not systematic. And extending
> ancestry checking on named v1 hierarchies seems backwards given
> the existence of the default hierarchy.

Yeah, identifying cgroup1 hierarchies by subsys leave out pretty good chunk
of usecases - e.g. systemd used to use a named hierarchy for primary process
organization on cgroup1.

Also, you don't have to switch to cgroup2 wholesale. You can just build the
same hierarchy in cgroup2 for process organization and combine that with any
cgroup1 hierarchies.

Thanks.

-- 
tejun
