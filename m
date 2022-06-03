Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE6853C390
	for <lists+cgroups@lfdr.de>; Fri,  3 Jun 2022 06:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbiFCEXr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jun 2022 00:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbiFCEXr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jun 2022 00:23:47 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B523935DC9
        for <cgroups@vger.kernel.org>; Thu,  2 Jun 2022 21:23:44 -0700 (PDT)
Message-ID: <b7c24414-a4d2-5a0a-3473-7df76a2257af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654230222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wPfpHB1TL79jIm4h7zpLLNq40C3N8P8MP8QnhyJBnmU=;
        b=UI4ysI84fFLOWkv8aa6WLVn+m4CGZW1sUydR8dmZcqqPublGhFuXs+Mdm2wG938URAtpPn
        Ez66JWI37VRsj49dXOsvXcOENfxa12+IlHuq53fQsnAK6g3M2uvofKMfkn6UYjs4DYHSaU
        4ChkpzNjX8BG6X4m/r52IQjkZIPQuW8=
Date:   Fri, 3 Jun 2022 07:23:40 +0300
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vasily Averin <vasily.averin@linux.dev>
Subject: Re: [PATCH] memcg: enable accounting in keyctl subsys
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yutian Yang <nglaive@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        cgroups@vger.kernel.org, linux-mm@kvack.org, shenwenbo@zju.edu.cn,
        Johannes Weiner <hannes@cmpxchg.org>, kernel@openvz.org,
        Jarkko Sakkinen <jarkko@kernel.org>
References: <1626682667-10771-1-git-send-email-nglaive@gmail.com>
 <0017e4c6-84d8-6d62-2ceb-4851771fec18@linux.dev>
 <YovnzLqXqEHY6SAC@kernel.org>
 <ca0ba233-ed09-5dce-5f38-2e05b1114610@linux.dev>
 <20220530133804.9215aa841958e84fdfe5272f@linux-foundation.org>
In-Reply-To: <20220530133804.9215aa841958e84fdfe5272f@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/30/22 23:38, Andrew Morton wrote:
> On Mon, 30 May 2022 12:38:28 +0300 Vasily Averin <vasily.averin@linux.dev> wrote:
> 
>> Dear Andrew,
>> could you please pick up this patch too?
>>
>> ...
>>
>>>> Reviewed-by: Vasily Averin <vvs@openvz.org>
>>
>> ...
>>
>>>> PS. Should I perhaps resend it?
> 
> Yes, would someone please resend.  And please also retest it - the
> patch is almost a year old.

Please postpone this patch, I need more time for investigations.

Thank you,
	Vasily Averin
