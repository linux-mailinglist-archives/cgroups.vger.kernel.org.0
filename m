Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766146AA0CC
	for <lists+cgroups@lfdr.de>; Fri,  3 Mar 2023 22:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjCCVDg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Mar 2023 16:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjCCVDf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Mar 2023 16:03:35 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A8015882;
        Fri,  3 Mar 2023 13:03:33 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id o12so15311689edb.9;
        Fri, 03 Mar 2023 13:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xllx/4GgK01h9KDl9QewJkuHS87v6oTCMIDEx+iw3vI=;
        b=nDA7wfgEeJY40M+BaOy5eLe+6K/mkMQ4ReZ3tVGy+7wnuxcu4rILBVqRr5d6NzNy1w
         L9mVFPg5YsE+mkRbm/WgFDkL0yLWJSullyuVZm17sInKeDvCjBsX+1JIvg6T8yrFDsBT
         gIdkYGw8t1uZszwPOGzQYxzD5xkgBoboc+UBWD0GpMnuy+9tTesdFioEnEbIM8ASv9Fp
         sxwJd3sGxsEKY4fwpR+qCCgxcaES2AC9KNvVTCr8vWiX8Bs6McXFflYJNm1py/PvBMVt
         KPNHFjYa/pK9x7fYiN5HENdp4xObGIVxDYuwM4Yrd5qaCr9SGTePiO9w1epqhkFGhg46
         mZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xllx/4GgK01h9KDl9QewJkuHS87v6oTCMIDEx+iw3vI=;
        b=HIoTTw0u958+U73TL+GlMLe3ojmHY6glX2A6OGUqyH8PJoK+gfZ323+KdUDEuxleN3
         i/O43/2OHav7z5t4QYZizTXDVeSOctkKm+I3/GZbbNpxZz3R7vmREeZP/bovCqWnrnSy
         lVhHmxEkooqWwf9+h5aGVnjcj5o8StKbpt9iKJOgsxuvhn1g6Fx0zkffhbjsnhO5mVLs
         FKQCs7G6BDL2IqXM1NbPqLpWBeaP1CcAHNkyV0pev857fH/3S008BJPm7yyra0AfhW+W
         wpsTzNRlWgSjDioOANkmrxKd7tMmsuCN2POqPwh4lgYqLVSMAsWLnRFYhFjbcIguRxvG
         MthQ==
X-Gm-Message-State: AO0yUKXMvgaTiG8mq1gVbQHrLmYNVoxx1fZ16WNTSp/2JRx+KP/pz6aU
        zypiPhLOAZIWQ42LrpvpqT8LdRFgZckRltdNp6w=
X-Google-Smtp-Source: AK7set/+ILI8/WrbT7vGPU26fjq5AWOdZeIypSjBjAf5Uonbtlp69JLAXLsON6Fxcy6jfQ42b5jp56cG9nY0CBiHk18=
X-Received: by 2002:a50:f60b:0:b0:4bf:5981:e5cc with SMTP id
 c11-20020a50f60b000000b004bf5981e5ccmr1625969edn.3.1677877412124; Fri, 03 Mar
 2023 13:03:32 -0800 (PST)
MIME-Version: 1.0
References: <20230303095310.238553-1-kamalesh.babulal@oracle.com> <ZAJfB/LuHtE5Iq3i@slm.duckdns.org>
In-Reply-To: <ZAJfB/LuHtE5Iq3i@slm.duckdns.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 3 Mar 2023 13:03:20 -0800
Message-ID: <CAADnVQJcKAvhUqJO9HJUQu6BfRw=dN=q+0o3CdhHX0Ei9-waAw@mail.gmail.com>
Subject: Re: [PATCH] cgroup: bpf: use cgroup_lock()/cgroup_unlock() wrappers
To:     Tejun Heo <tj@kernel.org>
Cc:     Kamalesh Babulal <kamalesh.babulal@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
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

On Fri, Mar 3, 2023 at 12:56=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Mar 03, 2023 at 03:23:10PM +0530, Kamalesh Babulal wrote:
> > Replace mutex_[un]lock() with cgroup_[un]lock() wrappers to stay
> > consistent across cgroup core and other subsystem code, while
> > operating on the cgroup_mutex.
>
> cgroup_[un]lock() were added because multi-gen lru wanted to lock
> cgroup_mutex from code which may be enabled even when cgroup is not enabl=
ed.
> That's the only place where that's the case. Hmm... it doesn't really mat=
ter
> I guess. Yeah, let's do this.
>
>   Acked-by: Tejun Heo <tj@kernel.org>
>
> Alexei, if you wanna take it through the bpf tree, please go ahead.
> Otherwise, I can route it through cgroup tree.

Either way is fine. diff stat says that cgroup directory has more changes,
so probably lesser chance of conflicts if it goes through cgroup tree.
So go ahead. Pls add:
Acked-by: Alexei Starovoitov <ast@kernel.org>
