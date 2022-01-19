Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F585493FC2
	for <lists+cgroups@lfdr.de>; Wed, 19 Jan 2022 19:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356695AbiASSWh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Jan 2022 13:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356688AbiASSWd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Jan 2022 13:22:33 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA4FC06173E
        for <cgroups@vger.kernel.org>; Wed, 19 Jan 2022 10:22:33 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id v186so10150562ybg.1
        for <cgroups@vger.kernel.org>; Wed, 19 Jan 2022 10:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ow/r3jR/x5GfOuGnuaEDOpHXZ2D5zk6XSR55QH2bw2k=;
        b=FLI8i7I5yY8vnry+xbaYi6fdQCzv/or9KmsXB8RqqToh1UZrTutJ8AvfQ35vIwRpaZ
         ZVIDvaMC9WrXJlmNwtpWjHaWlh2hOUrkwFG7C3i2Gjctt+KKhjxyftX7F345XteoowUn
         tmj3k+QHGMBCEsEd1hH7U0I28J5nEx8e5PpVhVuGXuhCte6lCImn19BiZqTDEqOw/Fdg
         fvcYZ8Aq05r+5q6HwLuIb9fePc6b1rxye0TZ4rjMY47us1/36Bhlc7LrAw524c1oJWJz
         AMiicIHHXoNcakeFhzP4hNVTgux4URUiw4uTdMc92CXEM0fnjkPofkv52VCekSlDs/yT
         fqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ow/r3jR/x5GfOuGnuaEDOpHXZ2D5zk6XSR55QH2bw2k=;
        b=aJD7N0IWhelJyLDJ0LLVsNNvFQw197vhp6O+JkM0Gp727isHPZwwDxN0ZDy6ld5Rlc
         /vqrWN94EDzUKW+5V9wzFL5pMaOLUmGnCRu+iQ3q/Evh0l4FxoGd+aH262bNxkZTE5wu
         saiTCRA7mosb2Ej3Kz1A5aRzm1qG+b4x3at25R94uVdU8PgwNWS2Jp4I3x/aQUWN8596
         AHFSa8PIAJbzsYvYEZsozu4Fm0aXDuS46YEcXKDUtEDn2dv+STjE6UnIL3uMnd4vaUf/
         REWS1qFXc4ZL2Gv6NhCfHRefFbmIxGAXKbca6z1UqX2ziSJSCuhGzObJERzcdbhdadrm
         4SaA==
X-Gm-Message-State: AOAM530jn/FizfDBCWzhePgRaMDOkpeZ7OGA8dSVtc4L54PFasbDCp+M
        QjRt2i1KhpAjhr5QOBTte3pgdUCvSbyeWdrh1uMp3g==
X-Google-Smtp-Source: ABdhPJyjjX5Kb9HEVQzIWK6/hD7hnVoGUHZFYjjUqWfesM5kj11GBi5GykhCeEhYDzwi5M4A2l0fMwN4mb/19ZPJHfM=
X-Received: by 2002:a5b:550:: with SMTP id r16mr38968597ybp.403.1642616552050;
 Wed, 19 Jan 2022 10:22:32 -0800 (PST)
MIME-Version: 1.0
References: <20220115010622.3185921-1-hridya@google.com> <20220115010622.3185921-5-hridya@google.com>
 <f8c8b196-7d12-6242-97ac-38149f3a3ba3@amd.com> <CA+wgaPMjCfjQS4LA8hmVwAaGfXZhoJvvTUnOGt3duOhFb3orTw@mail.gmail.com>
 <Yeg0GGi0tdnnCLHg@phenom.ffwll.local> <5cc27a05-8131-ce9b-dea1-5c75e994216d@amd.com>
In-Reply-To: <5cc27a05-8131-ce9b-dea1-5c75e994216d@amd.com>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Wed, 19 Jan 2022 10:21:56 -0800
Message-ID: <CA+wgaPMqN6HYfx4Abb=be0zN1BytyoP3jEWgaAW-x+POY0SgTQ@mail.gmail.com>
Subject: Re: [RFC 4/6] dma-buf: Add DMA-BUF exporter op to charge a DMA-BUF to
 a cgroup.
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Airlie <airlied@redhat.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Matthew Auld <matthew.auld@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Li Li <dualli@google.com>, Marco Ballesio <balejs@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Hang Lu <hangl@codeaurora.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Chris Down <chris@chrisdown.name>,
        Vipin Sharma <vipinsh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        cgroups@vger.kernel.org, Kenny.Ho@amd.com, daniels@collabora.com,
        kaleshsingh@google.com, tjmercier@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 19, 2022 at 7:58 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 19.01.22 um 16:54 schrieb Daniel Vetter:
> > On Tue, Jan 18, 2022 at 10:54:16AM -0800, Hridya Valsaraju wrote:
> >> On Sun, Jan 16, 2022 at 11:46 PM Christian K=C3=B6nig
> >> <christian.koenig@amd.com> wrote:
> >>> Am 15.01.22 um 02:06 schrieb Hridya Valsaraju:
> >>>> The optional exporter op provides a way for processes to transfer
> >>>> charge of a buffer to a different process. This is essential for the
> >>>> cases where a central allocator process does allocations for various
> >>>> subsystems, hands over the fd to the client who
> >>>> requested the memory and drops all references to the allocated memor=
y.
> >>>>
> >>>> Signed-off-by: Hridya Valsaraju <hridya@google.com>
> >>>> ---
> >>>>    include/linux/dma-buf.h | 18 ++++++++++++++++++
> >>>>    1 file changed, 18 insertions(+)
> >>>>
> >>>> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> >>>> index 7ab50076e7a6..d5e52f81cc6f 100644
> >>>> --- a/include/linux/dma-buf.h
> >>>> +++ b/include/linux/dma-buf.h
> >>>> @@ -13,6 +13,7 @@
> >>>>    #ifndef __DMA_BUF_H__
> >>>>    #define __DMA_BUF_H__
> >>>>
> >>>> +#include <linux/cgroup_gpu.h>
> >>>>    #include <linux/dma-buf-map.h>
> >>>>    #include <linux/file.h>
> >>>>    #include <linux/err.h>
> >>>> @@ -285,6 +286,23 @@ struct dma_buf_ops {
> >>>>
> >>>>        int (*vmap)(struct dma_buf *dmabuf, struct dma_buf_map *map);
> >>>>        void (*vunmap)(struct dma_buf *dmabuf, struct dma_buf_map *ma=
p);
> >>>> +
> >>>> +     /**
> >>>> +      * @charge_to_cgroup:
> >>>> +      *
> >>>> +      * This is called by an exporter to charge a buffer to the spe=
cified
> >>>> +      * cgroup.
> >>> Well that sentence makes absolutely no sense at all.
> >>>
> >>> The dma_buf_ops are supposed to be called by the DMA-buf subsystem on
> >>> behalves of the importer and never by the exporter itself.
> >>>
> >>> I hope that this is just a documentation mixup.
> >> Thank you for taking a look Christian!
> >>
> >> Yes, that was poor wording, sorry about that. It should instead say
> >> that the op would be called by the process the buffer is currently
> >> charged to in order to transfer the buffer's charge to a different
> >> cgroup. This is helpful in the case where a process acts as an
> >> allocator for multiple client processes and we would like the
> >> allocated buffers to be charged to the clients who requested their
> >> allocation(instead of the allocating process as is the default
> >> behavior). In Android, the graphics allocator HAL process[1] does
> >> most of the graphics allocations on behalf of various clients. After
> >> allocation, the HAL process passes the fd to the client over binder
> >> IPC and the binder driver invokes the charge_to_cgroup() DMA-BUF op to
> >> uncharge the buffer from the HAL process and charge it to the client
> >> process instead.
> >>
> >> [1]: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Fsource.android.com%2Fdevices%2Fgraphics%2Farch-bq-gralloc&amp;data=3D04%=
7C01%7Cchristian.koenig%40amd.com%7C838d25da974d4ea4257508d9db63eb70%7C3dd8=
961fe4884e608e11a82d994e183d%7C0%7C0%7C637782044488604857%7CUnknown%7CTWFpb=
GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7=
C3000&amp;sdata=3DQn7JeyF5Rq9tnrGw1KgNuQkpu5RbcrvPhDOa1OBJ6TU%3D&amp;reserv=
ed=3D0
> > For that use-case, do we really need to have the vfunc abstraction and
> > force all exporters to do something reasonable with it?
>
> I was about to write up a similar answer, but more from the technical sid=
e.
>
> Why in the world should that be done on the DMA-buf object as a
> communication function between importer and exporter?
>
> That design makes absolutely no sense at all to me.
>
> Regards,
> Christian.
>
> >
> > I think just storing the cgrpus gpu memory bucket this is charged again=
st
> > and doing this in a generic way would be a lot better.
> >
> > That way we can also easily add other neat features in the future, like
> > e.g. ttm could take care of charge-assignement automatically maybe, or =
we
> > could print the current cgroups charge relationship in the sysfs info
> > file. Or anything else really.

Thank you for the comments Daniel and Christian! I made the
charge/uncharge/transfer part of the exporter implementation since it
provided exporters a choice on whether they wanted to enable cgroup
memory accounting for the buffers they were exporting. I also see the
benefits of making the charge/uncharge/transfer generic by moving it
to the DMA-BUF framework like you are suggesting though. We will move
to a more generic design in the next version of the RFC.

Regards,
Hridya

> >
> > I do feel that in general for gpu memory cgroups to be useful, we shoul=
d
> > really have memory pools as a fairly strong concept. Otherwise every
> > driver/allocator/thing is going to come up with their own, and very lik=
ely
> > incompatible interpretation. And we end up with a supposed generic cgro=
ups
> > interface which cannot actually be used in a driver/vendor agnostic way=
 at
> > all.
> > -Daniel
> >
> >> Regards,
> >> Hridya
> >>
> >>
> >>> Regards,
> >>> Christian.
> >>>
> >>>>    The caller must hold a reference to @gpucg obtained via
> >>>> +      * gpucg_get(). The DMA-BUF will be uncharged from the cgroup =
it is
> >>>> +      * currently charged to before being charged to @gpucg. The ca=
ller must
> >>>> +      * belong to the cgroup the buffer is currently charged to.
> >>>> +      *
> >>>> +      * This callback is optional.
> >>>> +      *
> >>>> +      * Returns:
> >>>> +      *
> >>>> +      * 0 on success or negative error code on failure.
> >>>> +      */
> >>>> +     int (*charge_to_cgroup)(struct dma_buf *dmabuf, struct gpucg *=
gpucg);
> >>>>    };
> >>>>
> >>>>    /**
>
