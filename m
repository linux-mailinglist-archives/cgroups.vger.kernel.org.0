Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E9D5AF276
	for <lists+cgroups@lfdr.de>; Tue,  6 Sep 2022 19:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiIFR2M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Sep 2022 13:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238408AbiIFR14 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Sep 2022 13:27:56 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D791EE2A;
        Tue,  6 Sep 2022 10:19:23 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id q15so12023000pfn.11;
        Tue, 06 Sep 2022 10:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=DLlnc6RmTg0BKq5WkTFW6Fs5pUb+s+A4h9B4fzKjhrI=;
        b=csTIT6mI2KzzjqaY8cqY1Odnetkmo9YoZgm1ta/V1CfQXFGHrNl5ID11UWr9EwdqWT
         ybdIbatthK94dyrnSRNDRzDCley5Yk5BpAeFv0jlVOckHWFPIroZTDp8BT8QYEWrvkct
         BA4eS1H6rJQxAfoCXt7ExiwOLg+VBwXu131zL1best+97Y5E8nYjpo+rR0a96WS+Wzv7
         MjQLtS57kFrjmK6AclQeajykuyehhqAxxl6b2xCpvmumWgksYXgKSp//v3sHRcowshtU
         cRIDx7lZIZpbAiQjffFScK2mWcqYWBLsFSVHgLV9dxsr6wqBZCCZBcPK/KMRw6ofIq1L
         5hEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DLlnc6RmTg0BKq5WkTFW6Fs5pUb+s+A4h9B4fzKjhrI=;
        b=K+qVBmSeBKdclKp7xCaE7r7J8Qa1BCNLmu2b3VS+lAZoC+83N475YPiL5YrJBqvcSk
         9jMP5cbXgf8FGHKrhNMJO/uZzagJRDxI9/M+z6VHlxZD+VcS10rQwFIgoPz4N9EJ2ukZ
         drR8PyYZqmZMNaSbtpLZizK9YhIUAoXzU87FELe2aQpQ1jU5VJ5ak5MXIcXjaqf580y0
         eRL37oses8f9Ysoi3mXpgs+6surs4RVc8wi5CpRJg1Z7+kIh/HHgwlMfleVxW4nV/0jj
         k0Lt2ItpbkqrltDplh+6ZHbT3WK7alxgho65/5XEOAK/MsrhM6Aj/Wjt765XJ317y25B
         u6mg==
X-Gm-Message-State: ACgBeo2zk29F/NlPSrUXp10P/HMzR6CJqKGlhyMijsL1z9tPWAcknDkW
        EfJoJsQLLuB76/WhHkH7VpsCJsha8h8=
X-Google-Smtp-Source: AA6agR6DUk0XnuOm5ZGEH42iJ8VfksclmIYyolcIWWwZnbBPExrojB63b3kDCN+23GnniT1+npooqA==
X-Received: by 2002:aa7:8b52:0:b0:537:c6c7:3ef4 with SMTP id i18-20020aa78b52000000b00537c6c73ef4mr54402894pfd.48.1662484763130;
        Tue, 06 Sep 2022 10:19:23 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id v28-20020aa799dc000000b0053651308a1csm10539462pfi.195.2022.09.06.10.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 10:19:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 6 Sep 2022 07:19:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Phishing Risk] [External] Re: [PATCH] cgroup/cpuset: Add a new
 isolated mems.policy type.
Message-ID: <YxeBGeOaQxvlPLzo@slm.duckdns.org>
References: <20220902063303.1057-1-hezhongkun.hzk@bytedance.com>
 <YxT/liaotbiOod51@slm.duckdns.org>
 <c05bdeac-b354-0ac7-3233-27f8e5cbb38a@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c05bdeac-b354-0ac7-3233-27f8e5cbb38a@bytedance.com>
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

Hello,

On Mon, Sep 05, 2022 at 06:30:38PM +0800, Zhongkun He wrote:
> We usually use numactl to set the memory policy, but it cannot be changed
> dynamically. In addition, the mempolicy of cpuset can provide a more
> convenient interface for management and control panel.

But you can write a better tool easily in userspace to do whatever you wanna
do, right? If you're worried about racing against forks, you can freeze the
cgroup, iterate all pids applying whatever new policy and then unfreeze. We
can probably improve the freezer interface so that multiple users don't
conflict with each other but that shouldn't be too difficult to do and is
gonna be useful generically.

I don't see much point in adding something which can be almost trivially
implemented in userspace as a built-in kernel feature.

> Sorry,I don't quite understand the meaning of "don't enforce anything
> resource related". Does it mean mempolicy, such as "prefer:2" must specify
> node? Or "cpuset.mems.policy" need to specify a default value?
> (cpuset.mems.policy does not require a default value.)

In that there's no real resource being distributed hierarchically like cpu
cycles or memory capacities. All it's doing is changing attributes for a
group of processes, which can be done from userspace all the same.

Thanks.

-- 
tejun
