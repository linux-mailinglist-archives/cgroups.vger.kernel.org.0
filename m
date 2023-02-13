Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6201569463D
	for <lists+cgroups@lfdr.de>; Mon, 13 Feb 2023 13:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBMMru (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Feb 2023 07:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjBMMro (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Feb 2023 07:47:44 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0F03AB6
        for <cgroups@vger.kernel.org>; Mon, 13 Feb 2023 04:47:42 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id w3so5702462edc.2
        for <cgroups@vger.kernel.org>; Mon, 13 Feb 2023 04:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nametag.social; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rh4Kqn4+7KWXS3H/aKAK51ihf1ygtrczxgKWhB+Qs0w=;
        b=gJug4aVhXfibqFqH+coTt2+jvlis6+zE4jh3tnVRcFv3JobKmeOWVwP+1qi3fjjwHv
         Z1j+2C4QNPL+UvWdqn8XOcspI48GXcQeaxq+oNHa6AOdfroIdAO3X87RiazVQcIl+eBX
         3U4I7rdQ8ctXeKx9xqHJUhmPYvW4SGL5+WIkXBlmaAjIbEAu59JeVqb8sKTKMsbdC+P7
         p/skYrVgy7tXy65wjtM+V2bx2NehZYokREtay8Daqe/TtVz1xgFuL8hB06aJ/Fpzo1ke
         nrV75IT90nEb73KWIDOOB+pObyhF3USY7HMZfVDxKhRbSBBZhysCIyZZ9jTRzg55k1Ip
         nZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rh4Kqn4+7KWXS3H/aKAK51ihf1ygtrczxgKWhB+Qs0w=;
        b=UA6ShVXHp87A8PN/EwssZu+oQioO9TvBE+nLJne6wgIaCkZ464ht+EwVN/dMYHBlbo
         vPRuDue+h0Fj8J0djcXmR/hco0Q14RYIKs2jfChVJjsYDMtxYJhsnTNp5+2M/aETKg+y
         YC2ZeykvWeUOMqnPGcqpbto17roayu5boOYMwwH/qgo2zDuQr1Os00K0m5JpWB1brh4h
         wWWsdomYDdGcLx5nXSO609lTxTcPZh64RJQsSwNADiEc01SnZjtawJAG8I/p7PqnwFBS
         wSQdwtU9rL2q8d8DMnG8pD9EGNFz5D870hbJT6YEiPGeVdKVHVWHzQO5WPo+rIYpen0T
         HfwA==
X-Gm-Message-State: AO0yUKWwRHXJQlgVEvyqxXdj6V73iD2I6lL2c6l0jLDm/ixdKEZtfjwW
        7uAJnPA4Hdd3IX18eudKiqORUa/Xao4vhjMoIejUnJI8sPkg/k5W
X-Google-Smtp-Source: AK7set9gcONb5njWbyRgu/G0HiZH+DDmnQSFIgRwYpbyz42FqpX9wnUS38HXpSms5JsyZ6va/gTQ6P0zXcUMbr4pVVI=
X-Received: by 2002:a50:d098:0:b0:4ac:c838:5b4 with SMTP id
 v24-20020a50d098000000b004acc83805b4mr1122289edd.8.1676292460601; Mon, 13 Feb
 2023 04:47:40 -0800 (PST)
MIME-Version: 1.0
References: <CAM1kxwgN40r3tqdUFXPNgSAB3djMTDpDAXOACsS2zOF=LXxeyw@mail.gmail.com>
In-Reply-To: <CAM1kxwgN40r3tqdUFXPNgSAB3djMTDpDAXOACsS2zOF=LXxeyw@mail.gmail.com>
From:   Victor Stewart <v@nametag.social>
Date:   Mon, 13 Feb 2023 12:47:29 +0000
Message-ID: <CAM1kxwgh1expSb_zfLy-CDDcH_mNgJEmwNLxmF_YTEcDGgCSmw@mail.gmail.com>
Subject: Re: [BUG ?]: hugetlb.xxx[.rsvd].max implicit write failure
To:     cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 13, 2023 at 12:34 AM Victor Stewart <v@nametag.social> wrote:
>
> attempted to use hugetlb resource control for the first time. running 6.1.9
>
> create the subdirectory, then enable the hugetlb controller. reading the
> initial value of hugetlb.2MB.rsvd.max returns "max". i write 128 and receive a
> return value of 3. but then read hugetlb.2MB.rsvd.max and it now returns 0.
> same exact thing happens for hugetlb.2MB.max

ahh, it takes reads/writes with bytes as units, not 2MB pages.

kind of confusing and unexpected, even though memory works the same.

>
> so clearly the write is secretly failing somewhere even though the write
> operation return success?
>
> there are plenty of pages available:
>
> HugePages_Total:    4096
> HugePages_Free:     4096
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> Hugepagesize:       2048 kB
> Hugetlb:        13631488 kB
>
> none of the scarce documentation on this controller leads me to believe there's
> any required configuration beyond the above. so completely bewildered as to
> what's going wrong?
