Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334F766062C
	for <lists+cgroups@lfdr.de>; Fri,  6 Jan 2023 19:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjAFSHq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Jan 2023 13:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjAFSHp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Jan 2023 13:07:45 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20B411477
        for <cgroups@vger.kernel.org>; Fri,  6 Jan 2023 10:07:43 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id s67so1659530pgs.3
        for <cgroups@vger.kernel.org>; Fri, 06 Jan 2023 10:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//4YyY+R3Zvxj//qrfQ/8SUpcqPL2BUP4S2f+8LppsI=;
        b=GjNGe87iarMz9xzLWJbvuTpMDWCQA2+W1WVxnP+fJYjnmMv7m/6p9+01ELwcZGYByN
         sp+8DGsECa67c/twZDqrpNNIeNrZR84IzoPJgyp25dPCHvXXT7VlsAXvjYRBKMK9KT0K
         U3WxvQeLLXYTtteKi9iuV0Xmx18QLICl7dsCCpXPElWxet+sH1a4y7Y7TWBiTaU4nhZo
         80fA6E6O8WzBkJgHlTbZ5T2b4qjLpExO7alWown5M6oReIgqYyQXQq3dayus2N1Ut+S8
         V+J0Tf2Bq4Y+HIoRdcE92fZz0DNtzggABrgBoSijo2SFq+rEuHkMXS8gQRQAQeGL/gRn
         RKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=//4YyY+R3Zvxj//qrfQ/8SUpcqPL2BUP4S2f+8LppsI=;
        b=Etmu5Z3Uoz40H78zdAfR9S4R3YkTbLLa9eRR+gCN6KvT2jpitozF0eDr/zj4sogf6C
         rNyYAtZXdXIWa3u3CuzaKx2dYbgnbDEYUHY12Sc5AtIsDcwfQsJFYQ4NX02R49vuR8h2
         ol6Belv5YMaA9eF5KkGkisRLKcrbp6spREpAIFAabz18vCMSFn4z/dcKHe0+XrkidTIZ
         PHRG83pLu+oiiI5jS18mFAYvHlLKv4MCY2TAbP1enp110dsMckQHGh9bbU5X9Kh7fMPk
         aHm+tgcekc9N2y7EztmYPDSJgqJI+CeP0PGLh03l5XAIV6w+O7y1FhaO6RfwZxHfoZgF
         BCFw==
X-Gm-Message-State: AFqh2kozyAYqlCSzqUZmJBcRVme+7g3MO+7fjK9PU5KaY/0ieL17MHFJ
        smL187d7DQ4fNp7huibYqoL/6/Fg7sAr4pGA18I1GQ==
X-Google-Smtp-Source: AMrXdXtCwTCe/Z1erNxyHU+FOuguAbrMXDNIsjW7nphPRq8ZDn5GFcuLxYCKVdaiJMB4i952xNE3OA==
X-Received: by 2002:aa7:9154:0:b0:57b:30b6:9e85 with SMTP id 20-20020aa79154000000b0057b30b69e85mr54858191pfi.22.1673028463336;
        Fri, 06 Jan 2023 10:07:43 -0800 (PST)
Received: from [10.255.208.163] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id y12-20020aa78f2c000000b00581dd94be3asm1412263pfr.61.2023.01.06.10.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 10:07:42 -0800 (PST)
Message-ID: <c839ba6c-80ac-6d92-af64-5c0e1956ae93@bytedance.com>
Date:   Sat, 7 Jan 2023 02:07:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [External] Re: [PATCH v3] blk-throtl: Introduce sync and async
 queues for blk-throtl
To:     Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
References: <20221226130505.7186-1-hanjinke.666@bytedance.com>
 <20230105161854.GA1259@blackbody.suse.cz>
 <20230106153813.4ttyuikzaagkk2sc@quack3> <Y7hTHZQYsCX6EHIN@slm.duckdns.org>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <Y7hTHZQYsCX6EHIN@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2023/1/7 上午12:58, Tejun Heo 写道:

> 
> Jinke, is the case you described in the original email what you actually saw
> in production or a simplified test case for demonstration? If the latter,
> can you describe actual problems seen in production?
> 
> Thanks.
> 

Hi

In our internal scenario, iocost has been deployed as the main io 
isolation method and is gradually spreading。

But for some specific scenarios with old kernel versions, blk-throtl
is alose needed. The scenario described in my email is in the early 
stage of research and extensive testing for it. During this period，some 
priority inversion issues amoug cgroups or within one cgroup have been 
observed. So I send this patch to try to fix or mitigate some of these 
issues.

Thanks

Jinke
