Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D631373EBED
	for <lists+cgroups@lfdr.de>; Mon, 26 Jun 2023 22:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjFZUjh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Jun 2023 16:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjFZUjg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Jun 2023 16:39:36 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F00E58
        for <cgroups@vger.kernel.org>; Mon, 26 Jun 2023 13:39:30 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-55e0706af99so2905003eaf.1
        for <cgroups@vger.kernel.org>; Mon, 26 Jun 2023 13:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687811970; x=1690403970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEFUJeeBn6YjH4lK418olg3ruMKuxKIepWsfszUOpy4=;
        b=L6+t78u34A4EOsgO/5wyxp0/LGY+KJO2+xEm2/un0aE1W+UJ2WdK6S/UKVpguxRp5L
         R5MBxyaqs+VsDVFucNqfi5acwzpetEuEiNoaZ8TINLUMNyLQrLw5ImKiNAUPyZP6AkhM
         z9B43yz4ZPCStialiseimZwqXg90RajcVEsWa9D609XnTsfkElxPVXq9vzh/7VCTNHVv
         ziS22l4ZeeTvBn6hGJgR0FsPhw4xt3yYJhqLCQR4EOQ9FePLgVx2Z54nPJ8gKrH0uwRL
         cxZ5QZHAFRxraqfIGAatLgaElWfrPTD/K+Aa76+FxYyYGofVf9k/HTmhNNqiY77DmCW5
         0/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687811970; x=1690403970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEFUJeeBn6YjH4lK418olg3ruMKuxKIepWsfszUOpy4=;
        b=aWAl0vHmL1pAiaCD+qiyv8KMqbYoa+XOVSFN8vG3UP97DcVet/VgPURNnH9Ip/3hTw
         IN6eDyEJqWby9OtDZ3Pl83n6CwzqD94X2g90ocU/wR4hf/6IZ6dqHukuY3pjMkOR16v6
         wd46VYBMM/OmzchRJ+e0l/m0ydukv4SmC7IVNRjoWcK2YdKjomZNEh5ZQPlmI0nI84hh
         cDPz4buWPMGjREDGtVMmW6QQ+nSLVPcruChpTP4vaWohcBORviUxsbZzU7bmPDDZzfj9
         iUsiecYfmihSuCw2OXitehT7wemzVtoGvOQP9zSCdTKjpxpcyXl8PJZDPbXybakXhxUX
         oPQA==
X-Gm-Message-State: AC+VfDy01MZ0rQ7O1g+Zterdv3Cpm+LlDS67FS/LesqEokDI8GlVCmij
        R6MBr8VpCqUd9tda4Idw3Y1o6K8ZUe0Wj4Zp55eY3g==
X-Google-Smtp-Source: ACHHUZ4olQu8xtmPGwoaeFjq8yuKCjhhdxoXmfM/VHedl6d4Bu5m3oQg0VOJUL1hz/bBmYwBRV/mspwFs9D3oYgx/to=
X-Received: by 2002:a05:6358:cd1c:b0:132:71e7:15b6 with SMTP id
 gv28-20020a056358cd1c00b0013271e715b6mr13920779rwb.29.1687811969526; Mon, 26
 Jun 2023 13:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230626201713.1204982-1-surenb@google.com> <ZJn1tQDgfmcE7mNG@slm.duckdns.org>
In-Reply-To: <ZJn1tQDgfmcE7mNG@slm.duckdns.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 26 Jun 2023 13:39:18 -0700
Message-ID: <CAJuCfpGt8Bg1VLkx-aMw7_JTvh=co4QSM9B=fvikp0mQ-6rvjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
To:     Tejun Heo <tj@kernel.org>
Cc:     gregkh@linuxfoundation.org, peterz@infradead.org,
        lujialin4@huawei.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mingo@redhat.com, ebiggers@kernel.org, oleg@redhat.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, juri.lelli@redhat.com,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jun 26, 2023 at 1:31=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Jun 26, 2023 at 01:17:12PM -0700, Suren Baghdasaryan wrote:
> > diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> > index 73f5c120def8..a7e404ff31bb 100644
> > --- a/include/linux/kernfs.h
> > +++ b/include/linux/kernfs.h
> > @@ -273,6 +273,11 @@ struct kernfs_ops {
> >        */
> >       int (*open)(struct kernfs_open_file *of);
> >       void (*release)(struct kernfs_open_file *of);
> > +     /*
> > +      * Free resources tied to the lifecycle of the file, like a
> > +      * waitqueue used for polling.
> > +      */
> > +     void (*free)(struct kernfs_open_file *of);
>
> I think this can use a bit more commenting - ie. explain that release may=
 be
> called earlier than the actual freeing of the file and how that can lead =
to
> problems. Othre than that, looks fine to me.

Sure, once I get more feedback I'll post the next version with
expanded description.
Thanks!

>
> Greg, as Suren suggested, I can route both patches through the cgroup tre=
e
> if you're okay with it.
>
> Thanks.
>
> --
> tejun
