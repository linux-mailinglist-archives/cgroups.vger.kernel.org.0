Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B50E694DBC
	for <lists+cgroups@lfdr.de>; Mon, 13 Feb 2023 18:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjBMRKd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Feb 2023 12:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjBMRKc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Feb 2023 12:10:32 -0500
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ABF6E98;
        Mon, 13 Feb 2023 09:10:31 -0800 (PST)
Received: by mail-pj1-f44.google.com with SMTP id oa11-20020a17090b1bcb00b002341a2656e5so1345255pjb.1;
        Mon, 13 Feb 2023 09:10:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=43md4euKyTy5iM8nPRowlVg2uoHP+Bxebjf5efS9qUI=;
        b=g0YJA9Z6OLwaKXxkv9+jL0OzyhsRtI2CVlbEs+v18X4z0riyWkYjEGQKV/SMQRyyQK
         YO+vtEUYJlU/E6Tqn9CO/ybdaWoPe1GfK+FmU23NNZgExUJZHSMIt2rtt7NePZSv2uNr
         CawNBHoi50oEwm/PrnyUNzKws4vGY/GHpEQAB4TfjFJ6g2xEJOS/2/eSuLZiLkjdQTbM
         8RJvBTKi+7iNjwYENDG1Yd6vASupmORGUEH3xD1U/pySY9WIwZMk9ZOo/lTq8i82U3a4
         4WHzdAeiHpuo1dYQm8h4fLsYd5zmBaX/bgGVLY8FYULUSMuseXnsCreMSGOSZP/ylcdA
         D41A==
X-Gm-Message-State: AO0yUKUc0x0z2kJTiVaTCBYWsGa8aIOscG4YYVY/qKxsbGm9LU6I8MSY
        LDsIRIgjpumV5sK/A/7OIyo=
X-Google-Smtp-Source: AK7set/KgUpWGxPJNFJMKEcCvMQP9cXnNVjtmIdg3Yj20tnXZ+glv0aNSL8qHN0HGIOemEANUP74Yg==
X-Received: by 2002:a17:90b:d87:b0:234:1fa8:6589 with SMTP id bg7-20020a17090b0d8700b002341fa86589mr1103583pjb.6.1676308230508;
        Mon, 13 Feb 2023 09:10:30 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:dc5c:7c61:93f2:3d3d? ([2620:15c:211:201:dc5c:7c61:93f2:3d3d])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090a2d8900b00233bab35b57sm4956951pjd.29.2023.02.13.09.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 09:10:29 -0800 (PST)
Message-ID: <0290f608-6ddf-ecb7-4c05-55b0f7dbfbea@acm.org>
Date:   Mon, 13 Feb 2023 09:10:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] blk-ioprio: Introduce promote-to-rt policy
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>, Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, houtao1@huawei.com
References: <20230201045227.2203123-1-houtao@huaweicloud.com>
 <8c068af3-7199-11cf-5c69-a523c7c22d9a@acm.org>
 <4f7dcb3e-2d5a-cae3-0e1c-a82bcc3d2217@huaweicloud.com>
 <b6b3c498-e90b-7d1f-6ad5-a31334e433ae@acm.org>
 <beb7782e-72a4-c350-3750-23a767c88753@huaweicloud.com>
 <aedc240d-7c9e-248a-52d2-c9775f3e8ca1@acm.org>
 <20230208134345.77bdep3kzp52haxu@quack3>
 <7fcd4c38-ccbe-6411-e424-a57595ad9c0b@acm.org>
 <20230209085603.dzqfcc3pp4hacqlz@quack3>
 <55a065e7-7d86-d58f-15ba-c631a427843e@acm.org>
 <20230210101244.zsmtmsoo4xjx7suj@quack3>
 <48620099-0311-e752-ba3b-cbb4351cf81e@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <48620099-0311-e752-ba3b-cbb4351cf81e@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/13/23 04:51, Hou Tao wrote:
> Should I keep "none-to-rt" and make it work just like "promote-to-rt" or should
> I just remove "none-to-rt" and add "promote-to-rt" ? I think the latter will be
> more appropriate.

Removing none-to-rt would break existing systems that use this policy. I 
prefer the former solution.

Thanks,

Bart.

