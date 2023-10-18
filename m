Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232887CD28F
	for <lists+cgroups@lfdr.de>; Wed, 18 Oct 2023 05:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjJRDM7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Oct 2023 23:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJRDM7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Oct 2023 23:12:59 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D728FF;
        Tue, 17 Oct 2023 20:12:57 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-457c2d81f7fso2162758137.3;
        Tue, 17 Oct 2023 20:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697598776; x=1698203576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AghwLt6vblwpQhnA94BUMc1jL2ubPg4j6VP77aoRAzc=;
        b=UVo6ZKq+j/7sCFHrbzDkIhJA97jvQTqsIqxV47nwRb7V+XuWYDf3KJ2Mbg6N+GB6k9
         NI7wN1sqjwhMjYnylf85mJ9qzFwFrDrsMKR6+rBKtjDCgUV6ucrMt5dS5yD5Aq1ZA+hh
         xq4oXhVIEN1Oh07oAK0r2WoKTZW5KWgcU8384H9yE1eOYUnWSJK3jxPp5rNVngtx759f
         iQ3AkK1/z/e2TceezsVnaJ9JJQKC7EVVFg6w2WB2/T5p+uNCNSJ9i3f242ePgqzjX45C
         t64owlEkrDg/URlqzvv67HwC2aLtaGN9pv99/+qfEy+LkxWHegNVejE0NUoM+vnAXpyI
         9dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697598776; x=1698203576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AghwLt6vblwpQhnA94BUMc1jL2ubPg4j6VP77aoRAzc=;
        b=b2KXfHB2EXRKvHqBbQIVBicAHVLpbfcrjGp6g6YJAVGVk0l3msTsThsX2/CqS/rYtC
         WoHmdpwHKmrVLMZNSvEBjp8OFLh0sgtWydSoEyvOaa3gQ911cRWKzqsvEuwiDBwseeIW
         HAaNerUS1sGPlJQhqnD9RUMzr04S/dBZ/ZxaaejAplG6rkpz2P60kBgUAIXWT56Tp1Qa
         5VJfZ+Me9QHAToQQ1b6CBv1YdJai891k42KntMipU/xRSsZAqOeMJoqKTiEATr9R8//7
         M8r+EI+Z38F5D2b87ITnUaie2Jc0+xIru+CV7TOi+oe7dQ+jRBxSd4+QmJygWWPExCqr
         vkEQ==
X-Gm-Message-State: AOJu0YwsmJ5n+lwitJIkpZMspRpUB6rmNY7K+/SZNmiozGXdU5z7woA/
        3N0zhQLdTxkxlZL7QUcdZrGGSf91XGnEoMmPz3E=
X-Google-Smtp-Source: AGHT+IEj7G5WeYkodabVlnYoyo36Kp8Nsl/bPYtUNii0JHPGHyLEXA8gnlzq7lKQCQ9wY2xZQfeBv0xtfL5zvV1sb0Y=
X-Received: by 2002:a05:6102:2051:b0:457:c052:1949 with SMTP id
 q17-20020a056102205100b00457c0521949mr4573010vsr.25.1697598776608; Tue, 17
 Oct 2023 20:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231017124546.24608-1-laoar.shao@gmail.com> <20231017124546.24608-3-laoar.shao@gmail.com>
 <ujaxujz3xczccobmiu2jxsstn3n7v4ly7vp72dqbgu5dyonrrw@nhzk7fhrpkkp>
In-Reply-To: <ujaxujz3xczccobmiu2jxsstn3n7v4ly7vp72dqbgu5dyonrrw@nhzk7fhrpkkp>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 18 Oct 2023 11:12:20 +0800
Message-ID: <CALOAHbAgWoFGSc=uF5gFWXmsALECUaGGScQuXpRcwjgzv+TPGQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 2/9] cgroup: Eliminate the need for
 cgroup_mutex in proc_cgroup_show()
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        sinquersw@gmail.com, cgroups@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 17, 2023 at 10:04=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.c=
om> wrote:
>
> Hi.
>
> I'd like this proc_cgroup_show de-contention.
> (Provided the previous patch and this one can be worked out somehow.)

Thanks

>
> On Tue, Oct 17, 2023 at 12:45:39PM +0000, Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > They can ran successfully after implementing this change, with no RCU
> > warnings in dmesg. It's worth noting that this change can also catch
> > deleted cgroups, as demonstrated by running the following task at the
> > same time:
>
> Can those be other than v1 root cgroups? A suffix "(unmounted)" may be
> more informative then.

They can only be a v1 root cgroups. will use the "(unmounted)"
instead. Thanks for your suggestion.

>
> (Non-zombie tasks prevent their cgroup removal, zombie tasks won't have
> any non-trivial path rendered.)
>
>
> > @@ -6256,7 +6256,7 @@ int proc_cgroup_show(struct seq_file *m, struct p=
id_namespace *ns,
> >       if (!buf)
> >               goto out;
> >
> > -     cgroup_lock();
> > +     rcu_read_lock();
>
> What about the cgroup_path_ns_locked() that prints the path?

I believe we can further enhance cgroup_path_ns() by replacing the
cgroup_lock with rcu_read_lock. However, we need to explicitly address
the NULL root case, which may necessitate some refactoring. Perhaps
this can be improved in a separate patchset?

>
> (I argue above that no non-trivial path is rendered but I'm not sure
> whether rcu_read_lock() is sufficient sync wrt cgroup rmdir.)
>


--=20
Regards
Yafang
