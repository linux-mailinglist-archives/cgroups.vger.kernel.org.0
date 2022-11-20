Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BFA63152B
	for <lists+cgroups@lfdr.de>; Sun, 20 Nov 2022 17:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiKTQZT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 20 Nov 2022 11:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKTQZS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 20 Nov 2022 11:25:18 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F1B2DDB;
        Sun, 20 Nov 2022 08:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1668961514;
        bh=n1RHYaSr7YVqpR8H4s00LHMTau2igcsd/5bJkmmJeNU=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=pRHgB9QTxpHTbMYjOUJS8PqOUVjx2KvI2Lxodd+h9qHf0pQCvDVJi7WkHXSAY19Qm
         MljcSA6rjBNuSm2tuErOP7ZWZsPcKfTh5o7JQojVBC+BAK9Njz1B1vWK3Y4wq5cgCi
         VVKcVitj2q63UqJCdmm4jJ8ALaWB2yXLXsIXOodY=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id ECE3D128115A;
        Sun, 20 Nov 2022 11:25:14 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ldle52qfiSPc; Sun, 20 Nov 2022 11:25:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1668961514;
        bh=n1RHYaSr7YVqpR8H4s00LHMTau2igcsd/5bJkmmJeNU=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=pRHgB9QTxpHTbMYjOUJS8PqOUVjx2KvI2Lxodd+h9qHf0pQCvDVJi7WkHXSAY19Qm
         MljcSA6rjBNuSm2tuErOP7ZWZsPcKfTh5o7JQojVBC+BAK9Njz1B1vWK3Y4wq5cgCi
         VVKcVitj2q63UqJCdmm4jJ8ALaWB2yXLXsIXOodY=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3ACCA1280FD2;
        Sun, 20 Nov 2022 11:25:14 -0500 (EST)
Message-ID: <77e79fad98b945f4f3f72b584d10fe01e187b8a8.camel@HansenPartnership.com>
Subject: Re: [PATCH] cgroup: Fix typo in comment
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "haifeng.xu" <haifeng.xu@shopee.com>, tj@kernel.org
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 20 Nov 2022 11:25:11 -0500
In-Reply-To: <20221120155134.57193-1-haifeng.xu@shopee.com>
References: <20221120155134.57193-1-haifeng.xu@shopee.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, 2022-11-20 at 15:51 +0000, haifeng.xu wrote:
> Replace iff with if.

You can't do this without a more detailed analysis.  iff means if and
only if (logical implies in both directions), which appears to be more
correct in the code being patched than if, which is logical implies in
only one direction only.

James

