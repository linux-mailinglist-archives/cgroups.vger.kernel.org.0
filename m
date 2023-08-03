Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AD776EBF9
	for <lists+cgroups@lfdr.de>; Thu,  3 Aug 2023 16:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjHCOKO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Aug 2023 10:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbjHCOJ6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Aug 2023 10:09:58 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A22F46B7
        for <cgroups@vger.kernel.org>; Thu,  3 Aug 2023 07:08:58 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40fc670197aso9919221cf.1
        for <cgroups@vger.kernel.org>; Thu, 03 Aug 2023 07:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1691071737; x=1691676537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4X70XiZqAzKDHaedlFT+O6kVH6sN4dN95C3n7UPaI38=;
        b=T1AVtnxqWcjaufF6bv7ocvKEpv91EiKq2B0bub6zitZRPI7irFp95rXVUQQBisS3mx
         9C8bHB8K2hIQK1UwCdmzg8TBRyKaqfPcX7wXtW3/iGZ1QfYbL1R3I0ay50EyUPU6kLps
         Gv01kO8HtQNFGy0JNctEC+XIBX+lfXDebDOB+ZW3dS9lACnW1+4d64cVQSmnH817WGVa
         pNzE59AxqqBagCEyBO188I6O24sotquYt+4zwTIA2SQ3YCW4BzMD48+MhEcNraVkUhd8
         qfVFVmk8aKW+cWZgjVzUrsumGsWCkjQIrqVHqRTLkLK/nCViDhjUCBrvCiMpSYb2AXtm
         TScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071737; x=1691676537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4X70XiZqAzKDHaedlFT+O6kVH6sN4dN95C3n7UPaI38=;
        b=VXL21Zs/4CsPbTRc+r4uEDtqyUHZATf9mMKMfG3O//wc6117RItrh0g+sU6uu8r9/T
         nslXTul+3nOAAZ4CB9yM+w1TqaUoDssHdv/h3KMWzPuVrEo7FFKYqwfV3O+hWPhgLrP7
         20cJZJxz+XhnwHCmfs5o1V4oHmLSWpus8stT24aLegmazECXXvrvvBbA38braqJgZdB+
         /caMpRU38wcDrYuKcmg6Vsz8hPpCHe2UvVLXKiLW786TZB8SZCDWFi6n9jK/fxRw0XEj
         lKg7xV2SD7QiNOjQLt1zNchePuqz58bEo9YNd8KZdzvqdGZoYfRg54knHROchMrhb/tu
         v27w==
X-Gm-Message-State: ABy/qLYSwFMe7YckN5VGwUsDO1ia1X6Rh8pO4rHShKqbDrvd469EGKnp
        gr6Snlz+OS/6VexCQlAdFuFKCg==
X-Google-Smtp-Source: APBJJlGBsI72+QtlKPGJaDPIHSHdf11ytTQoRzvXUleTdXDJmCD5BDgtYNCEjNzkix2CkvP4A5GC4w==
X-Received: by 2002:a05:622a:182:b0:403:ec6d:4e46 with SMTP id s2-20020a05622a018200b00403ec6d4e46mr23447225qtw.13.1691071736733;
        Thu, 03 Aug 2023 07:08:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:9910])
        by smtp.gmail.com with ESMTPSA id eo7-20020a05622a544700b0040c57ea0fb8sm4500120qtb.49.2023.08.03.07.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:08:56 -0700 (PDT)
Date:   Thu, 3 Aug 2023 10:08:55 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: fix wrong function name above
 obj_cgroup_charge_zswap()
Message-ID: <20230803140855.GA219857@cmpxchg.org>
References: <20230803120021.762279-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803120021.762279-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 03, 2023 at 08:00:21PM +0800, Miaohe Lin wrote:
> The correct function name is obj_cgroup_may_zswap(). Correct the comment.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
