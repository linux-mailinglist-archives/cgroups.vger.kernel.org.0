Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E9B51CD08
	for <lists+cgroups@lfdr.de>; Fri,  6 May 2022 01:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387005AbiEFAAZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 May 2022 20:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386988AbiEFAAY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 May 2022 20:00:24 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38EB60DA6
        for <cgroups@vger.kernel.org>; Thu,  5 May 2022 16:56:42 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id p4so6959434edx.0
        for <cgroups@vger.kernel.org>; Thu, 05 May 2022 16:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uWiEhWmhMDzG0ZpwCc+KvFHmta+dLhGoAJnxSBDiro8=;
        b=CaBQ1UXw8e392aHxUqO7YzvZNbVO299KOlkxDA3WGrY9BWShRdfHWTf0i0Tdsc0Z4x
         Zgp4Gq8IkAZ61hhLujTNwr7ZXt3+q6wrr7TWIsSa3R0i/tELL2+yAzMh5esa0TCqwJjl
         F/5g78AXRbrvZs5gyHBEnx6Uj/Y4QIjKYxUmn38VJVxgSqmyUH1by4gck/j5PJ+AjqT+
         BCOGzPJ0WCkgbOLhtqewqTMnmy5zyvK3ubf+kCmfpaL0Fm6d4f06nN2nMq53FagcwD13
         1/6oImedxy6bVsDtMqoGLQAS79JNnWcFY/mAdKcBZe7DOuOn/8sY8HI2NP6NDwRdgjvN
         Jsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uWiEhWmhMDzG0ZpwCc+KvFHmta+dLhGoAJnxSBDiro8=;
        b=I+vE2r0DSw94uA0wg9uldSOSwdL+Muz+ulu+MHbAmDjIBpwYUIjfKYYO4PcxYw5ob8
         5cEMso5Er+SXYw8xNL8TFmLjbPg1rpBWCSIVr8qtOs0XlL0Sackc/LeYk2rqAuoTdwUC
         6cYwSnJ+YxF9shFc/vvy/lkS/OLr4RdiT+Pw5cx7G9xxS2wpDWH59p9tsaWVMJclmEyb
         1vagY7ZiSUNy6I5zRWHq5P904jP5liaZZEIVJp6CxWx06Ivji8HxBc4ps5gC0aRsArxg
         adU8JS4RmFUskcF6qxUZELgj9byFKTdzH/YvLsVISOrGBjuMOd4r7mOPMwLkC7031CfN
         xX3Q==
X-Gm-Message-State: AOAM533R2sq9FBZtePdG/eAEH5LIyFz4aFwnloCWCdnslEZYdwHb1/pb
        4q1y5aaWg+ZNhBttO6Dl8MsFRUj/OxxJ72dNrjpWrg==
X-Google-Smtp-Source: ABdhPJxBVsYL/HmPz5Si6AZ374lQlB+QZq/MgvSO76eUd0MC1TXZ0G1DD2y30Q2fgAaRR4bq7DsCqSpNFU8IXCPJ+NQ=
X-Received: by 2002:a05:6402:2397:b0:426:4967:8574 with SMTP id
 j23-20020a056402239700b0042649678574mr744975eda.197.1651795001436; Thu, 05
 May 2022 16:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220502231944.3891435-1-tjmercier@google.com>
 <20220502231944.3891435-2-tjmercier@google.com> <20220504121052.GA24172@blackbody.suse.cz>
 <CABdmKX2nbXLrngK8XRFCBCP=Zz-AMgKviiUdpWvEiYc-jOqang@mail.gmail.com> <20220505112908.GC10890@blackbody.suse.cz>
In-Reply-To: <20220505112908.GC10890@blackbody.suse.cz>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Thu, 5 May 2022 16:56:30 -0700
Message-ID: <CABdmKX26mY3xYL0drv51t5_3tmUTbExZtjN73KU8bpP8ZJ5CgA@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] gpu: rfc: Proposal for a GPU cgroup controller
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hridya Valsaraju <hridya@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        John Stultz <jstultz@google.com>,
        Todd Kjos <tkjos@android.com>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        kernel-team@android.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, May 5, 2022 at 4:29 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> On Wed, May 04, 2022 at 10:16:50AM -0700, "T.J. Mercier" <tjmercier@googl=
e.com> wrote:
> > However the only names that would result from this series are the
> > names of the dma-buf heaps, with "-heap" appended. So they are
> > predictable from the /dev/dma_heap/* names, and only the system and
> > cma heaps currently exist upstream.
>
> It's not so important with the read-only stats currently posted (a
> crafted sysfs file with these names would be an overlikill)...
>
> >
> > For other future uses of this controller I thought we were headed in
> > the direction of "standardized" names which would be
> > predefined/hardcoded and documented, so these names wouldn't really
> > need to be made available to a user at runtime.
> > https://lore.kernel.org/lkml/CABdmKX3gTAohaOwkNccGrQyXN9tzT-oEVibO5ZPF+=
eP+Vq=3DAOg@mail.gmail.com/
>
> (Ah, I see.)
>
> ...but if writers (limits) are envisioned, the keys should represent
> something that the user can derive/construct from available info -- e.g.
> the documentation.
>
> OK, so I understand current form just presents some statistics.
>
Yup, thanks for taking a look.

> Michal
