Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2686F53449B
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 21:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiEYT4k (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 15:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346466AbiEYT4T (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 15:56:19 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A80528718;
        Wed, 25 May 2022 12:56:18 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id p8so20125185pfh.8;
        Wed, 25 May 2022 12:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=URc4hQQOFWu8kbxQu3QsbQGjnzXbOZhtvLuWIaavPVo=;
        b=RZi+79Hik/m6u3wnR25JW2Eu4n1JgneXWTduAnjWgkibjAUptWSbRpJ/yAkrdLMjD2
         zVtQrJbZvvXIbaN/kJoEuTcBz6tB/iee0q14OliDGrfzioIgl0m3OgDlE1isO5jQ5M0U
         Hf23JVDQ/CwVGy+7Sm5UGNzwt977TJUB3VgbByqxwV7r8zrqKiDxC4OF+i4K4Xn1pFi6
         WwPsrbOGhlzEftQRcxP5RFv0Q6eW4lNDFABhcKo7fyqy8bOVX6fqm/72xWOA1s9Xt7/U
         hZk44k/5mvppgUzxRkGckH0bPkbgdvkowstF1bfh3lckOFCuOXdD1Rr1K5o+Ucy/LSHf
         rmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=URc4hQQOFWu8kbxQu3QsbQGjnzXbOZhtvLuWIaavPVo=;
        b=sejuCXRbH7YD3sYnUeClCl0lzu1+VkxB4AOtjwto1FPkSInzITKaokln/yatrVw+/Q
         Ytv1HQT0+jGvwpM7ibtrHRrinhBSQo0dx9sXDhGNPUUUvQCtvv1oVvfE7q5hfmrZFMMR
         PxfEtSFxjDWcYENLgXmphkfxUy2Gx4jIaFGW2H4vP0/qGH9oS97HOTvThAxaJA3RkUM8
         BGjAWRD0aJPOK11KdclQTNA8sJ/mrC+uExHvkIqEbVRJZF8XhO7VxhQJOzddUBkA9oxk
         Qlvn/HU2km8lWPQ9sAEy8fAb70/e6hlejtbGZz0FaIPelYFI8ppWWtiBugfJTubEZzq8
         FeVw==
X-Gm-Message-State: AOAM532HS2tBcPZgZeT8lkTLr0MdNcJdqHXHRfcOgJrIobKSez0GPZXA
        2VqFUT1vaj5Hh7LgHYyfHlM=
X-Google-Smtp-Source: ABdhPJzAhUcVtGFwJmSmE72i8FoA9WsdPAkuCadrn+f6PQSHiI/29tdM+Z+WIXkHG9f4bv6joyAIEQ==
X-Received: by 2002:aa7:83d0:0:b0:50c:eb2b:8e8a with SMTP id j16-20020aa783d0000000b0050ceb2b8e8amr35026479pfn.31.1653508577737;
        Wed, 25 May 2022 12:56:17 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:aafd])
        by smtp.gmail.com with ESMTPSA id cx19-20020a17090afd9300b001dcf49d92a1sm2224252pjb.28.2022.05.25.12.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 12:56:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 25 May 2022 09:56:15 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [GIT PULL] cgroup changes for v5.19-rc1
Message-ID: <Yo6J3/cVHu4huZH1@slm.duckdns.org>
References: <Yowcc/ZOBIIs2JtZ@slm.duckdns.org>
 <CAHk-=wiGsJgFTJ=yqYwWA2vcTWQy=2QQ6to6vd3ETutaE0cDxQ@mail.gmail.com>
 <Yo6HMpEodz36o4Dc@slm.duckdns.org>
 <CAHk-=wj4Q2++KfQ4NhMtjmJF_1bjC-573U61o1acuHfqmsvCKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj4Q2++KfQ4NhMtjmJF_1bjC-573U61o1acuHfqmsvCKA@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 25, 2022 at 12:47:48PM -0700, Linus Torvalds wrote:
> On Wed, May 25, 2022 at 12:44 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hahaha, yeah, I lost my private key many years ago, so gotta get that sorted
> > out first. Will do the signed pull from now on.
> 
> You have a pgp key for your kernel.org account, you can just use that. No?
>
> (That way I'll also be able to just pick it up from the pgp key repo
> that Konstantin maintains).

I don't have the private part of that pgp key anymore and have been just
using the same ssh key. Nothing really requires the private key that I lost
at least 5 years ago. On the plus side, the pgp key has been as secure as it
gets. :) So, I gotta generate new keys, get it signed and replace the korg
key and so on. I've just been really lazy.

Thanks.

-- 
tejun
