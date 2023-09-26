Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4CE7AE3E7
	for <lists+cgroups@lfdr.de>; Tue, 26 Sep 2023 05:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjIZDB4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Sep 2023 23:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjIZDBy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Sep 2023 23:01:54 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C3D9F;
        Mon, 25 Sep 2023 20:01:47 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-65af726775eso22773836d6.0;
        Mon, 25 Sep 2023 20:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695697306; x=1696302106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Irbbz1pd7BMY5vzJH82iICB1EXsa28Rc+uh6SDLIjf8=;
        b=ZtkXntJzn92p5jhwFrmgARLwGgMokjCfAT8lmJPI30LDfdkTb1T9jZ8aVTdKmaOm/x
         3TVCucH61zDYCVeomgh3KzTfgCU+pVw/zv8c1RTPp5jdMYilwR6o3uclGqNgopi9bRn0
         awpywotDc0RiJkddApNHLlwx0adHFpYgz09G8e6wfPAK/4VJ3j+oH6oTCYlyo13Lmjm3
         aSliAqq6eQ50/X3Qw5kCrOlIi+ZAOFDZzdPvTr/YRHRpuMAbO3jgiNJxNmVCActA7BeR
         g5kmW6T2Wr0SzLJBaFRGFcv5prW3dTTMkaSXu6o+HQ3aRY+SGCep71IL/Tfm0RLnI3Z3
         Yw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695697306; x=1696302106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Irbbz1pd7BMY5vzJH82iICB1EXsa28Rc+uh6SDLIjf8=;
        b=LCmUeV1nwjWis0bm5Vw4LAL0e9s6npABv5OzvesW10HU8dobh5gyKhiH4dkJ7s8edw
         vJk0l9CZxSwG3VtAGIGikKP+PMYOX3UpzaoznGxzICLsu1il93gU9XOEpmXfUBbdOewb
         6REs0xHrVHxmGQOe9ivlKtodA8Gm2dQAjUIf0iGT+WfIO+gWJNMf8/r4Lo5TBDwXvFdG
         UYpKo3yVlZv9is2oWkqrPi4R/Iq7rgGx2iCsGQe0wlqC9G80p+ReUt8NfYVBmqOHjvbL
         zuMQVsTd2nDEBu/znZoTGnO5LHG1Xu5O0sGE2z8ugfIyVpz58d6TI2zdXHzwmMO3MW0Z
         BU7Q==
X-Gm-Message-State: AOJu0YwxwigRp8lGOkKFLJQGzBoEVcBHy0+pJJDfnAbkNGQNqS0QqjFj
        oFFA1tTtCQri9pbPf54m9WUhClAuOrUdskVmI84=
X-Google-Smtp-Source: AGHT+IFrTgYovBaX7C8HhhSu5hbDN5sNxb/v69YafL/y61i6YvM32e2xmCVEISSgVZbUkXzSBkCq/23E4wpY2m4gkIo=
X-Received: by 2002:a05:6214:5b0f:b0:65b:12b1:d54f with SMTP id
 ma15-20020a0562145b0f00b0065b12b1d54fmr1749649qvb.22.1695697306651; Mon, 25
 Sep 2023 20:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230922112846.4265-1-laoar.shao@gmail.com> <ZQ3GQmYrYyKAg2uK@slm.duckdns.org>
 <CALOAHbA9-BT1daw-KXHtsrN=uRQyt-p6LU=BEpvF2Yk42A_Vxw@mail.gmail.com> <ZRHU6MfwqRxjBFUH@slm.duckdns.org>
In-Reply-To: <ZRHU6MfwqRxjBFUH@slm.duckdns.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 26 Sep 2023 11:01:08 +0800
Message-ID: <CALOAHbB3WPwz0iZNSFbQU9HyGBC9Kymhq2zV83PbEYhzmmvz4g@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/8] bpf, cgroup: Add bpf support for cgroup controller
To:     Tejun Heo <tj@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
        cgroups@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 26, 2023 at 2:43=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Sun, Sep 24, 2023 at 02:32:14PM +0800, Yafang Shao wrote:
> > On Sat, Sep 23, 2023 at 12:52=E2=80=AFAM Tejun Heo <tj@kernel.org> wrot=
e:
> > >
> > > Hello,
> > >
> > > On Fri, Sep 22, 2023 at 11:28:38AM +0000, Yafang Shao wrote:
> > > > - bpf_cgroup_id_from_task_within_controller
> > > >   Retrieves the cgroup ID from a task within a specific cgroup cont=
roller.
> > > > - bpf_cgroup_acquire_from_id_within_controller
> > > >   Acquires the cgroup from a cgroup ID within a specific cgroup con=
troller.
> > > > - bpf_cgroup_ancestor_id_from_task_within_controller
> > > >   Retrieves the ancestor cgroup ID from a task within a specific cg=
roup
> > > >   controller.
> > > >
> > > > The advantage of these new BPF kfuncs is their ability to abstract =
away the
> > > > complexities of cgroup hierarchies, irrespective of whether they in=
volve
> > > > cgroup1 or cgroup2.
> > >
> > > I'm afraid this is more likely to bring the unnecessary complexities =
of
> > > cgroup1 into cgroup2.
> >
> > I concur with the idea that we should avoid introducing the
> > complexities of cgroup1 into cgroup2. Which specific change do you
> > believe might introduce these complexities into cgroup2? Is it the
> > modification within task_under_cgroup_hierarchy() or
> > cgroup_get_from_id()?
>
> The helpers you are adding only makes sense for cgroup1. e.g.
> bpf_cgroup_ancestor_id_from_task_within_controller() makes no sense in
> cgroup2. The ancestor ids don't change according to controllers. The only
> thing you would ask in cgroup2 is the level at which a given controller i=
s
> enabled at along with the straight-forward "where am I in the hierarchy?"
> questions. I really don't want to expose interfaces which assume that the
> hierarchies change according to the controller in question.

Makes sense.

>
> Also, as pointed out before, this doesn't cover cgroup1 named hierarchies
> which leaves out a good potion of cgroup1 use cases.
>
> > In fact, we have the option to utilize
> > bpf_cgroup_ancestor_id_from_task_within_controller() as a substitute
> > for bpf_task_under_cgroup(), which allows us to sidestep the need for
> > changes within task_under_cgroup_hierarchy() altogether.
>
> I don't think this is the direction we should take. If you really want,
> please tie the interface directly to the hierarchies. Don't hitch hierarc=
hy
> identificdation on the controllers. e.g. Introduce cgroup1 only interface
> which takes both hierarchy ID and cgroup ID to operate on them.

Thanks for your suggestion. I will think about it.
BTW, I can't find the hierarchy ID of systemd (/sys/fs/cgroup/systemd)
in /proc/cgroups. Is this intentional as part of the design, or might
it be possible that we overlooked it?
In the userspace, where can we find the hierarchy ID of a named hierarchy?

--=20
Regards
Yafang
