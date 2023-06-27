Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438C874024B
	for <lists+cgroups@lfdr.de>; Tue, 27 Jun 2023 19:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjF0Rgi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jun 2023 13:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjF0Rgf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Jun 2023 13:36:35 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5417C296E
        for <cgroups@vger.kernel.org>; Tue, 27 Jun 2023 10:36:33 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5702415be17so39954407b3.2
        for <cgroups@vger.kernel.org>; Tue, 27 Jun 2023 10:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687887392; x=1690479392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=se2ReXfTDI0bXoCNygO1qTaRa/855o/ehreExnjKHr4=;
        b=UbiFd6YoylHJILWdhk6BfqhqffX7VZGyKqllKO+PLZxQgyXEVk7mLWiCPmMOH0eG1A
         mz4x3Z55tg1CsUsg9y5/38jsuMiEGWpTEQsU8IHLE6s9l73ZN4tt6JHXtzXyWoSqZodT
         CJ4SOcXTjvD3Ab6tdreO3k/QraNDuA04zVIsO7NwaQ1mUyQ18XfMQcxX0xfbLkyTZ0ka
         bRPn6/iTaf0QK3v/2n1QveesbyfGhn4ArML8353gQvj9YDEgvbAF7kJoEi6lJNa+zf4H
         Q/aAUDW/oj0lYLERWPtfXkfaFIGuITEF8dIbtHK1BFK4Vx5rVC1d2fjbye7WlBFg9M3Z
         aEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687887392; x=1690479392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=se2ReXfTDI0bXoCNygO1qTaRa/855o/ehreExnjKHr4=;
        b=IP1H8sSjKH7wstCmGU/QDshjCxEZVAqdrom7m5Pm3gypWRPv7EQf0qUJaSxc3SUCxU
         L81oenSH7BJpWgDK4mAXId4gtTxbV6uBM/Sy/uSb62m2bXHxZHfK1engGMZh2+hsQGjN
         EOvYfQx3MeoFSZBrF1P7xOdckpUTjCHuYHk09nF/PdyO9WwroBVsP/4Z0xSVXhGcS6Nm
         75mvMwEiPYm4DRwHcXTxvG0BvtphI5JmtyyNicbxs85zdHsSpdwYg4fQCLrfR2smLxfw
         bhUFLzi6BtwXCONtBIvHIPv0HSMW3Xwgf3hvPK6uk9Yf2KEcJxAlX08K7N+gZNlhW+gy
         QM2w==
X-Gm-Message-State: AC+VfDzFxMC6x60CkXqIe0C5g9odPBfm2wHDgWot9zacKVEmYsAcXET3
        KgGH6y0nR9ocB4jvLZqZN30g1c8BwiuNkH+gCOzMFw==
X-Google-Smtp-Source: ACHHUZ4o8iwMgDjk5itLTB9+M9VoLuXmrM0hsgBgCO3fmiHxYnwXveCnBiOTJaiocWtWPk48Iqf5DxIR9cdJwWbTyBA=
X-Received: by 2002:a25:549:0:b0:bc7:947e:2fcd with SMTP id
 70-20020a250549000000b00bc7947e2fcdmr20991175ybf.35.1687887392275; Tue, 27
 Jun 2023 10:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230626201713.1204982-1-surenb@google.com> <ZJn1tQDgfmcE7mNG@slm.duckdns.org>
 <20230627-kanon-hievt-bfdb583ddaa6@brauner> <CAJuCfpECKqYiekDK6Zw58w10n1T4Q3R+2nymfHX2ZGfQVDC3VQ@mail.gmail.com>
 <20230627-ausgaben-brauhaus-a33e292558d8@brauner>
In-Reply-To: <20230627-ausgaben-brauhaus-a33e292558d8@brauner>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 27 Jun 2023 10:36:21 -0700
Message-ID: <CAJuCfpGSntZwfzyeHYOYOcmLJvj80DKTUnj+y-DFVF524C3eVw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
To:     Christian Brauner <brauner@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, gregkh@linuxfoundation.org,
        peterz@infradead.org, lujialin4@huawei.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        ebiggers@kernel.org, oleg@redhat.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jun 27, 2023 at 10:30=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Tue, Jun 27, 2023 at 10:09:27AM -0700, Suren Baghdasaryan wrote:
> > On Tue, Jun 27, 2023 at 1:24=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Mon, Jun 26, 2023 at 10:31:49AM -1000, Tejun Heo wrote:
> > > > On Mon, Jun 26, 2023 at 01:17:12PM -0700, Suren Baghdasaryan wrote:
> > > > > diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> > > > > index 73f5c120def8..a7e404ff31bb 100644
> > > > > --- a/include/linux/kernfs.h
> > > > > +++ b/include/linux/kernfs.h
> > > > > @@ -273,6 +273,11 @@ struct kernfs_ops {
> > > > >      */
> > > > >     int (*open)(struct kernfs_open_file *of);
> > > > >     void (*release)(struct kernfs_open_file *of);
> > > > > +   /*
> > > > > +    * Free resources tied to the lifecycle of the file, like a
> > > > > +    * waitqueue used for polling.
> > > > > +    */
> > > > > +   void (*free)(struct kernfs_open_file *of);
> > > >
> > > > I think this can use a bit more commenting - ie. explain that relea=
se may be
> > > > called earlier than the actual freeing of the file and how that can=
 lead to
> > > > problems. Othre than that, looks fine to me.
> > >
> > > It seems the more natural thing to do would be to introduce a ->drain=
()
> > > operation and order it before ->release(), no?
> >
> > I assume you mean we should add a ->drain() operation and call it when
> > kernfs_drain_open_files()  causes kernfs_release_file()? That would
> > work but if any existing release() handler counts on the current
> > behavior (release() being called while draining) then we should find
> > and fix these. Hopefully they don't really depend on the current
> > behavior but I dunno.
>
> Before I wrote that I did a naive
>
>         > git grep -A 20 kernfs_ops | grep \\.release
>         kernel/cgroup/cgroup.c- .release                =3D cgroup_file_r=
elease,
>         kernel/cgroup/cgroup.c- .release                =3D cgroup_file_r=
elease,
>
> which only gave cgroup_release_file(). Might be I'm missing some convolut=
ed
> callchains though or macro magic...
>
> ->release() was added in
>
>     commit 0e67db2f9fe91937e798e3d7d22c50a8438187e1
>     kernfs: add kernfs_ops->open/release() callbacks
>
>     Add ->open/release() methods to kernfs_ops.  ->open() is called when
>     the file is opened and ->release() when the file is either released o=
r
>     severed.  These callbacks can be used, for example, to manage
>     persistent caching objects over multiple seq_file iterations.
>
>     Signed-off-by: Tejun Heo <tj@kernel.org>
>     Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Acked-by: Acked-by: Zefan Li <lizefan@huawei.com>
>
>
> which mentions "either releases or severed" which imho already points to
> separate methods.

Interesting. I guess we can add op->drain() and make all existing
handlers of ops->release() to handle ops->drain() with the same
handler. That should keep them happy and for my case I'll be releasing
resources only inside ops->release(). Does that sound good?

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
