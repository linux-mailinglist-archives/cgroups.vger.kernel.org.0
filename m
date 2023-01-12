Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262AF666998
	for <lists+cgroups@lfdr.de>; Thu, 12 Jan 2023 04:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbjALD04 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Jan 2023 22:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbjALD0v (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Jan 2023 22:26:51 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A9CC77E
        for <cgroups@vger.kernel.org>; Wed, 11 Jan 2023 19:26:49 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b17so11396359pld.7
        for <cgroups@vger.kernel.org>; Wed, 11 Jan 2023 19:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsH0mjnH0SeMzrOGfLla9s5TybpBmyzM+PHEYBJpLrQ=;
        b=8NifJggs/yh5SMPhQK1Rns2F/N9YHJzl2Ypi9i9jYMCq8JvNLfeXx0wDvwNbHAEYZS
         aiNsnWSqgv0g2jFpnl9MK1Y2zgFOOtY1/Cr1ukz7V2f3c//7jqoojUzeAWiPtkAkNsu3
         y5NrTN9VglZvUCli+KS+Fuep2brgdFlSuTBp++iYWwI3HI8Urzjnp02w/NY3kipmZii8
         UqqCazVNBK5ELchNv1pdLGUa9DDY77/ME9StIercWWbZEJGmjbAcWyWNj+BuzivqdALs
         /zWjgQfVGjobtikFVWg83AqJJYWvGhvXR0D+XrKxLiyTjTVPhVt3cnyakg9mR7p1e29N
         I3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SsH0mjnH0SeMzrOGfLla9s5TybpBmyzM+PHEYBJpLrQ=;
        b=1t9rxs/Rgr9EwvWr/zfekMhm+CY3ua6BtSt0IPWlMCvFZs3dnEqUmFR5lbXytCKNma
         rc3nnERySsrv3JYhhnN1xg0Bei84kQiF2LNhZM22Ifem2weo0K44cTqWCQxqhfCZMBLt
         gf1WEeD/E9+SFBbtGGiqyYjJQwVkui5ui9E28YSkUTty1I89ANdIZc+wkK+z6UoGT1y2
         v5SGzKZOInOhrnBlN48KP0t09smhdEOUj+oK1o20wiOSE2Gay94elZirknDU5LvNbTqx
         Vs9tFNvw9F8AV5czCKP3AfDwy+39dWQhAhkQvPEOrX4YWx2RY+qIgp81O0TaK9UU4nMA
         lePQ==
X-Gm-Message-State: AFqh2kogszP76zHboLGzht//hs1ctWH+U5WZSinXffo3JgxGU9owgIM0
        4CppdfjJUO2t/xQgHzizU61Gog==
X-Google-Smtp-Source: AMrXdXs4Ye9cDgkUChsXanRTIAebOqSR6oXMlmyQWNMKcPppTo5A7P42knpZBvwRXjZt+s2Vc/cKow==
X-Received: by 2002:a17:902:76cb:b0:18d:dd85:303c with SMTP id j11-20020a17090276cb00b0018ddd85303cmr4554834plt.8.1673494008887;
        Wed, 11 Jan 2023 19:26:48 -0800 (PST)
Received: from [10.254.85.126] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id t1-20020a170902d14100b00186b3c3e2dasm10959022plt.155.2023.01.11.19.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 19:26:48 -0800 (PST)
Message-ID: <0e03867e-54ea-fb10-1f8a-f098c9dbb026@bytedance.com>
Date:   Thu, 12 Jan 2023 11:26:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [External] Re: [PATCH v3] blk-throtl: Introduce sync and async
 queues for blk-throtl
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
References: <20221226130505.7186-1-hanjinke.666@bytedance.com>
 <20230105161854.GA1259@blackbody.suse.cz>
 <20230106153813.4ttyuikzaagkk2sc@quack3> <Y7hTHZQYsCX6EHIN@slm.duckdns.org>
 <c839ba6c-80ac-6d92-af64-5c0e1956ae93@bytedance.com>
 <20230111123532.GB3673@blackbody.suse.cz>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <20230111123532.GB3673@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2023/1/11 下午8:35, Michal Koutný 写道:
> Hello.
> 
> Thanks all for sharing ideas and more details (in time-previous messages).
> 
> On Sat, Jan 07, 2023 at 02:07:38AM +0800, hanjinke <hanjinke.666@bytedance.com> wrote:
>> But for some specific scenarios with old kernel versions, blk-throtl
>> is alose needed. The scenario described in my email is in the early stage of
>> research and extensive testing for it. During this period，some priority
>> inversion issues amoug cgroups or within one cgroup have been observed. So I
>> send this patch to try to fix or mitigate some of these issues.
> 
> Jinke, do you combine blk-throtl with memory limits? (As that could in theory
> indirectly reduce async requests as dirtier would be slowed down.)
> 

Hi

In fact, some of those tests above are done in vm with only total 16g 
memory.

Agree with what you said, if we further tighten the memory usage, things 
will get better because this will indirectly reduces writeback pages in
blk-throtl queue.

Thanks.
