Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8B851AC0A
	for <lists+cgroups@lfdr.de>; Wed,  4 May 2022 20:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359687AbiEDSFd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 May 2022 14:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376307AbiEDSFM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 May 2022 14:05:12 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3C76A01E
        for <cgroups@vger.kernel.org>; Wed,  4 May 2022 10:19:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id dk23so4164274ejb.8
        for <cgroups@vger.kernel.org>; Wed, 04 May 2022 10:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=53tRH3Jax00x2MRGmAnmpVFoogtTBVaQBwRaJB/MSqI=;
        b=ZpE/QIW7kna1o4IhzQQmp2637K1w9UcjrBWQkFmB3KeaXGJhRew5Qrrm4nVBxQuM5K
         WxvhUYOlh8rWIuTX2aM0865lrsFa3LgNJmonYVw5QJ5TWtJ8GDZTmeKTt6ABumWC0QC1
         ab5RGTAVBbqKEoK4b/TnHXAunRyIDb4UtS/WiYRpJvoKPoGFBe/xxsjE1LJ0+w1IU9lY
         PawaTzdNF1YTKYIh5MvHjBCSHId3sE7LkENrHud89JTEUmJh7bVKtkqT2eRSPldXBLZc
         Hy/1AeX5w6TUxiRTh+7aDA0ELWkG6xjnd2RXfENi04bsD7m5bd6YKUkx+vX1cIkHwdrw
         TrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=53tRH3Jax00x2MRGmAnmpVFoogtTBVaQBwRaJB/MSqI=;
        b=VUeVDY5Tx7OYYmPzAMR8k1NN+0ZjQZMFrdI0DB95OlQ0tZKMhRv/JEJ/B/9I9ADT3f
         SdfcFsLEmEa8LnwNxdH5cdQVpd8KspmcKSmA09wOmWPu3whlDR5lY33umijQ0zBBIYy8
         GATjO2o1I6bIAE3Qmf+DlhSNKpIOSX26zaBh0xXYOuLpEmNwdL0Cgw7brK0kriGWEn8c
         FRPO7DkUQotMwVmSV6Y3sjSwiagr57PSEaSFuPzlvWQUuomimePxq8vrnb9QxxmNdoUq
         W8OFHFIN5NeS1igXYZwqt5iR67kvCft7gM+rYN5+sK1D4G/AR70c29x6O/zsT6ogdvmb
         INTA==
X-Gm-Message-State: AOAM531hrx+I+GMfjfx7TlWt0+bjTlYpAg9gj67Hr7v8JwMGVJDhq4L/
        h/cjeyXyi3WaoCnWxESIJG/5uk9NX/qElWS3nntSNQ==
X-Google-Smtp-Source: ABdhPJzYz0aK430SRVDxLl+B+OuSgn1cw903dQC7G1sXXHkRu7glc7gEEQOV/ft7a8r9UmYDzaVlBuVy0a6wROfL2lA=
X-Received: by 2002:a17:907:971e:b0:6f3:ff27:ebf7 with SMTP id
 jg30-20020a170907971e00b006f3ff27ebf7mr21159148ejc.159.1651684771561; Wed, 04
 May 2022 10:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220502231944.3891435-1-tjmercier@google.com>
 <20220502231944.3891435-3-tjmercier@google.com> <20220504122558.GB24172@blackbody.suse.cz>
In-Reply-To: <20220504122558.GB24172@blackbody.suse.cz>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Wed, 4 May 2022 10:19:20 -0700
Message-ID: <CABdmKX2DJy0i3XAP7xTduZ8KFVKtgto24w714YJNUb_=pfYiKw@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] cgroup: gpu: Add a cgroup controller for allocator
 attribution of GPU memory
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hridya Valsaraju <hridya@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        John Stultz <jstultz@google.com>,
        Todd Kjos <tkjos@android.com>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 4, 2022 at 5:26 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> Hello.
>
> On Mon, May 02, 2022 at 11:19:36PM +0000, "T.J. Mercier" <tjmercier@googl=
e.com> wrote:
> > This patch adds APIs to:
> > -allow a device to register for memory accounting using the GPU cgroup
> > controller.
> > -charge and uncharge allocated memory to a cgroup.
>
> Is this API for separately built consumers?
> The respective functions should be exported (EXPORT_SYMBOL_GPL) if I
> haven't missed anything.
>
As the only users are dmabuf heaps and dmabuf, and those cannot be
built as modules I did not export the symbols here. However these
definitely would need to be exported to support use by modules, and I
have had to do that in one of my device test trees for this change.
Should I export these now for this series?

> > +#ifdef CONFIG_CGROUP_GPU
> > + /* The GPU cgroup controller data structure */
> > +struct gpucg {
> > +     struct cgroup_subsys_state css;
> > +
> > +     /* list of all resource pools that belong to this cgroup */
> > +     struct list_head rpools;
> > +};
> > +
> > +/* A named entity representing bucket of tracked memory. */
> > +struct gpucg_bucket {
> > +     /* list of various resource pools in various cgroups that the buc=
ket is part of */
> > +     struct list_head rpools;
> > +
> > +     /* list of all buckets registered for GPU cgroup accounting */
> > +     struct list_head bucket_node;
> > +
> > +     /* string to be used as identifier for accounting and limit setti=
ng */
> > +     const char *name;
> > +};
>
> Do these struct have to be defined "publicly"?
> I.e. the driver code could just work with gpucg and gpucg_bucket
> pointers.
>
> > +int gpucg_register_bucket(struct gpucg_bucket *bucket, const char *nam=
e)
>
> ...and the registration function would return a pointer to newly
> (internally) allocated gpucg_bucket.
>
No, except maybe the gpucg_bucket name which I can add an accessor
function for. Won't this mean depending on LTO for potential inlining
of the functions currently implemented in the header? I'm happy to
make this change, but I wonder why some parts of the kernel take this
approach and others do not.

> Regards,
> Michal
