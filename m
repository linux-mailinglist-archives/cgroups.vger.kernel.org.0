Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16717ADF30
	for <lists+cgroups@lfdr.de>; Mon, 25 Sep 2023 20:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjIYSoB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Sep 2023 14:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbjIYSoB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Sep 2023 14:44:01 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094A99B;
        Mon, 25 Sep 2023 11:43:55 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b9e478e122so4338584a34.1;
        Mon, 25 Sep 2023 11:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695667434; x=1696272234; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4rW0kJ8enQ9kzrxneD0npJWJJ1FtuYSvDFI9OIwG44c=;
        b=c5uvNahyMI19XMwjTFFCXW9FKvwQ1wDUZ/OisXPYKzwjelurwcIVILYwk0ZjgVu6M2
         7jlyGwsPx4cnIYqzn1rm4sz8OnutNMsF1NzREQMPhjqbe4wThhIrvVY9wAeK/RYootmT
         zJq2l19OXbIfpqgJG13eSjT016SxB2Y7BCXDjUpKhrFvpcgTMrnsg4ryw/2TIABzxIn7
         t85tPuBVa7TuQ/ZDPwdWgBdcgLdeugjZoWhRireh6T5pujJtwymkucZ0x/IUzPz4K29X
         inzQAOFlHzWMZaJzZ/NKUTbXY/jWSTX9ezE1vIbfKv1mPsGy4t6KNmDTC46zgRxRDzgg
         GjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695667434; x=1696272234;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rW0kJ8enQ9kzrxneD0npJWJJ1FtuYSvDFI9OIwG44c=;
        b=XjeZUIlmn633ieAcHxUOMzihnPX+QJfNcFfkUwuwWAmZ6+E4nGoQRbFvbQBCyyL2gF
         v7YuA03AmCQ43JZrZvUoXOl7svIlPmOfB4Bvgtw11VR7j+EnKWf2yL4EWOi0/hff+vtm
         qa1THeUK6ev7CyivP2ze4ENKuxRNQgoZ/NDQdz0qFRpByK4ZNKJqKCVLF2GnCliAiogh
         oQbRJ2Z+f+6pdnhfjT8K29qTkomnjXMYBZDqQC+jCnodmVGZ6ZyKuQnOF7mQCLYLWnG1
         7tx7FQ/1qQH8ucaGS/inKF4cemnsfmJjUWCGyImskmvLp3eMoNOvNVkwcUEPIOQJWdrp
         qsVw==
X-Gm-Message-State: AOJu0Yz+9vxd1T1w37adySKH6ofVWLWqdy6pAgS1WlAbLr5HWGJnm8J4
        UYwEL5o4tZC/3CZQL2pTsOQ=
X-Google-Smtp-Source: AGHT+IEB076Ma8stkRXNvx+3gNTNeZ52c/UqJq1C/w2BacEJNCN/ufrIj7CpwufA19qtuC1PlD6wuA==
X-Received: by 2002:a05:6358:881f:b0:143:8eb4:cf36 with SMTP id hv31-20020a056358881f00b001438eb4cf36mr8217480rwb.5.1695667434187;
        Mon, 25 Sep 2023 11:43:54 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:dfcd])
        by smtp.gmail.com with ESMTPSA id i187-20020a639dc4000000b0050f85ef50d1sm8156530pgd.26.2023.09.25.11.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:43:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 25 Sep 2023 08:43:52 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
        cgroups@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 0/8] bpf, cgroup: Add bpf support for cgroup
 controller
Message-ID: <ZRHU6MfwqRxjBFUH@slm.duckdns.org>
References: <20230922112846.4265-1-laoar.shao@gmail.com>
 <ZQ3GQmYrYyKAg2uK@slm.duckdns.org>
 <CALOAHbA9-BT1daw-KXHtsrN=uRQyt-p6LU=BEpvF2Yk42A_Vxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbA9-BT1daw-KXHtsrN=uRQyt-p6LU=BEpvF2Yk42A_Vxw@mail.gmail.com>
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

On Sun, Sep 24, 2023 at 02:32:14PM +0800, Yafang Shao wrote:
> On Sat, Sep 23, 2023 at 12:52 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello,
> >
> > On Fri, Sep 22, 2023 at 11:28:38AM +0000, Yafang Shao wrote:
> > > - bpf_cgroup_id_from_task_within_controller
> > >   Retrieves the cgroup ID from a task within a specific cgroup controller.
> > > - bpf_cgroup_acquire_from_id_within_controller
> > >   Acquires the cgroup from a cgroup ID within a specific cgroup controller.
> > > - bpf_cgroup_ancestor_id_from_task_within_controller
> > >   Retrieves the ancestor cgroup ID from a task within a specific cgroup
> > >   controller.
> > >
> > > The advantage of these new BPF kfuncs is their ability to abstract away the
> > > complexities of cgroup hierarchies, irrespective of whether they involve
> > > cgroup1 or cgroup2.
> >
> > I'm afraid this is more likely to bring the unnecessary complexities of
> > cgroup1 into cgroup2.
> 
> I concur with the idea that we should avoid introducing the
> complexities of cgroup1 into cgroup2. Which specific change do you
> believe might introduce these complexities into cgroup2? Is it the
> modification within task_under_cgroup_hierarchy() or
> cgroup_get_from_id()?

The helpers you are adding only makes sense for cgroup1. e.g.
bpf_cgroup_ancestor_id_from_task_within_controller() makes no sense in
cgroup2. The ancestor ids don't change according to controllers. The only
thing you would ask in cgroup2 is the level at which a given controller is
enabled at along with the straight-forward "where am I in the hierarchy?"
questions. I really don't want to expose interfaces which assume that the
hierarchies change according to the controller in question.

Also, as pointed out before, this doesn't cover cgroup1 named hierarchies
which leaves out a good potion of cgroup1 use cases.

> In fact, we have the option to utilize
> bpf_cgroup_ancestor_id_from_task_within_controller() as a substitute
> for bpf_task_under_cgroup(), which allows us to sidestep the need for
> changes within task_under_cgroup_hierarchy() altogether.

I don't think this is the direction we should take. If you really want,
please tie the interface directly to the hierarchies. Don't hitch hierarchy
identificdation on the controllers. e.g. Introduce cgroup1 only interface
which takes both hierarchy ID and cgroup ID to operate on them.

Thanks.

-- 
tejun
