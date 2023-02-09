Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF846910FF
	for <lists+cgroups@lfdr.de>; Thu,  9 Feb 2023 20:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjBITJk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Feb 2023 14:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBITJj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Feb 2023 14:09:39 -0500
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F79658F6;
        Thu,  9 Feb 2023 11:09:37 -0800 (PST)
Received: by mail-pl1-f180.google.com with SMTP id u9so3936943plr.9;
        Thu, 09 Feb 2023 11:09:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=03jnNn8D8Zd31Z8vK5q3T/UQbdP/Vod7or8RrPZ1S6g=;
        b=xRROc2r07tsoL1eDQm7RaIOlFyYGNocmlEK1pie6GJxSFOAzT+HG/vTghej6w8HuMn
         G1JJ6BVUdhU3CqClALRwxmQiS4LK/3BdOfmpM5fRStOBqiaJpK5ubL0X5oXHz5mMLmjP
         SndGYYzVPlzW4M3MrpzaDqk2Vw1kXIZIE9QH98AfVGkxD9T1bY+L9npL/ebNcv9ntZ4k
         AjHjHX4nJofhJ/dEWmO07tUVdzx4vxYZmn0bnY8qKKaaA6+YANtA3JzlUn+skL1PrCW1
         lPruQ+Fqhh8K59I6vazK+C6TYdZPrDDKSoWYDT+mm5fxonZ3DhTXMy8gKjXJMbRu84WF
         k2EA==
X-Gm-Message-State: AO0yUKUalmO9lv3wTRCdCJG2izYSsmuAsb8GnOKE2x7bWEMzlGspPcjr
        Qzs89fN9yjrNWQ080vpmHMCKreVLrhM=
X-Google-Smtp-Source: AK7set9V8EYWT/iJLRXzBb9vqHUdZJNLRLMQ+tsi+3G8JKvcD91PpjY19v5/M1blxF+vYQ5PeyuYcw==
X-Received: by 2002:a05:6a21:6716:b0:bc:6e88:7f58 with SMTP id wh22-20020a056a21671600b000bc6e887f58mr9158372pzb.51.1675969776553;
        Thu, 09 Feb 2023 11:09:36 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:15f5:48f5:6861:f3f6? ([2620:15c:211:201:15f5:48f5:6861:f3f6])
        by smtp.gmail.com with ESMTPSA id g9-20020a633749000000b004db367c10b0sm1614705pgn.46.2023.02.09.11.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 11:09:35 -0800 (PST)
Message-ID: <55a065e7-7d86-d58f-15ba-c631a427843e@acm.org>
Date:   Thu, 9 Feb 2023 11:09:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] blk-ioprio: Introduce promote-to-rt policy
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Hou Tao <houtao@huaweicloud.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230209085603.dzqfcc3pp4hacqlz@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/9/23 00:56, Jan Kara wrote:
> On Wed 08-02-23 09:53:41, Bart Van Assche wrote:
>> The test results I shared some time ago show that IOPRIO_CLASS_NONE was the
>> default I/O priority two years ago (see also https://lore.kernel.org/linux-block/20210927220328.1410161-5-bvanassche@acm.org/).
>> The none-to-rt policy increases the priority of bio's that have not been
>> assigned an I/O priority to RT. Does this answer your question?
> 
> Not quite. I know that historically we didn't set bio I/O priority in some
> paths (but we did set it in other paths such as some (but not all) direct
> IO implementations). But that was exactly a mess because how none-to-rt
> actually behaved depended on the exact details of the kernel internal IO
> path.  So my question is: Was none-to-rt actually just a misnomer and the
> intended behavior was "always override to RT"? Or what was exactly the
> expectation around when IO priority is not set and should be overridden?
> 
> How should it interact with AIO submissions with IOCB_FLAG_IOPRIO? How
> should it interact with task having its IO priority modified with
> ioprio_set(2)? And what if task has its normal scheduling priority modified
> but that translates into different IO priority (which happens in
> __get_task_ioprio())?
> 
> So I think that none-to-rt is just poorly defined and if we can just get
> rid of it (or redefine to promote-to-rt), that would be good. But maybe I'm
> missing some intended usecase...

Hi Jan,

We have no plans to use the ioprio_set() system call since it only 
affects foreground I/O and not page cache writeback.

While Android supports io_uring, there are no plans to support libaio in 
the Android C library (Bionic).

Regarding __get_task_ioprio(), I haven't found any code in that function 
that derives an I/O priority from the scheduling priority. Did I perhaps 
overlook something?

Until recently "none-to-rt" meant "if no I/O priority has been assigned 
to a task, use IOPRIO_CLASS_RT". Promoting the I/O priority to 
IOPRIO_CLASS_RT works for us. I'm fine with changing the meaning of 
"none-to-rt" into promoting the I/O priority class to RT. Introducing 
"promote-to-rt" as a synonym of "none-to-rt" is also fine with me.

Thanks,

Bart.
