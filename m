Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03436A4558
	for <lists+cgroups@lfdr.de>; Mon, 27 Feb 2023 15:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjB0O5v (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Feb 2023 09:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjB0O5u (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Feb 2023 09:57:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211C455AE
        for <cgroups@vger.kernel.org>; Mon, 27 Feb 2023 06:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677509824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ss2xMFtfBNj0edm2OxxXiynydqERuSjVgjdxnPnjzQc=;
        b=KE1749iYuF7wwoAMXLnyxesjAKaYaYcK8QYIK7lVER3tb4mfRdZtv3QrBVLDDnI/wx+r1R
        bIqJGq+Ftaic81cnEIiNfnEC+Hx8aaM6rBfpCHQhXd/Y6jDbn5xD5W7IMcP9D2Y//XO1RD
        QV5Y6vw1thads9hAtntLgOTE1uAVVLs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-Bi6cNJeVNdaBYRjUsOErNA-1; Mon, 27 Feb 2023 09:57:00 -0500
X-MC-Unique: Bi6cNJeVNdaBYRjUsOErNA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6118101A55E;
        Mon, 27 Feb 2023 14:56:59 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C87302166B2B;
        Mon, 27 Feb 2023 14:56:59 +0000 (UTC)
Message-ID: <9953284e-05da-56b0-047d-ecf18aa53892@redhat.com>
Date:   Mon, 27 Feb 2023 09:56:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] cpuset: Remove unused cpuset_node_allowed
Content-Language: en-US
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     lizefan.x@bytedance.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230227080719.20280-1-haifeng.xu@shopee.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230227080719.20280-1-haifeng.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/27/23 03:07, Haifeng Xu wrote:
> Commit 002f290627c2 ("cpuset: use static key better and convert to new API")
> has used __cpuset_node_allowed instead of cpuset_node_allowed to check
> whether we can allocate on a memory node. Now this function isn't used by
> anyone, so we can remove it safely.
>
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>   include/linux/cpuset.h | 12 ------------
>   1 file changed, 12 deletions(-)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index d58e0476ee8e..7fad5afe3bba 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -82,13 +82,6 @@ int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask);
>   
>   extern bool __cpuset_node_allowed(int node, gfp_t gfp_mask);
>   
> -static inline bool cpuset_node_allowed(int node, gfp_t gfp_mask)
> -{
> -	if (cpusets_enabled())
> -		return __cpuset_node_allowed(node, gfp_mask);
> -	return true;
> -}
> -
>   static inline bool __cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
>   {
>   	return __cpuset_node_allowed(zone_to_nid(z), gfp_mask);
> @@ -223,11 +216,6 @@ static inline int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask)
>   	return 1;
>   }
>   
> -static inline bool cpuset_node_allowed(int node, gfp_t gfp_mask)
> -{
> -	return true;
> -}
> -
>   static inline bool __cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
>   {
>   	return true;

The kernel convention is to add a "__" prefix to a function name if 
there is higher level helper without the "__" prefix that uses it. Since 
cpuset_node_allowed() is no longer used. We should just rename 
__cpuset_node_allowed() to cpuset_node_allowed() and get rid of the 
unused helper. A bit more code changes are needed for this, though.

Cheers,
Longman

