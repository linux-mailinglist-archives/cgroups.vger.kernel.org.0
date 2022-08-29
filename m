Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E085A501F
	for <lists+cgroups@lfdr.de>; Mon, 29 Aug 2022 17:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiH2PYy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Aug 2022 11:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiH2PYy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Aug 2022 11:24:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659F22DEA
        for <cgroups@vger.kernel.org>; Mon, 29 Aug 2022 08:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661786689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r8Pa70Jwmk85yjbhdC2p9Q8zUFSafHf+XccH6FABnLg=;
        b=RBVijxX1E1rOp8BcIYuE8ozNhmHEIHAA0Jdr3TSqeVuxR2fXLnevE4//m36hLMKgqzw1fD
        CRC8xc9u9kfAw+yH5iejHc9zJtIdMlgjFhKtSQxFTbIg6jH7WkLPE7wpHvh78RoZQ3YRe9
        Fgnln2LFVAUKKmMl+jUqmU4B1i6UeCw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-WVHeO-9aNzGgSwP5gayNkg-1; Mon, 29 Aug 2022 11:24:47 -0400
X-MC-Unique: WVHeO-9aNzGgSwP5gayNkg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15D793804505;
        Mon, 29 Aug 2022 15:24:47 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2E46492C3B;
        Mon, 29 Aug 2022 15:24:46 +0000 (UTC)
Message-ID: <ef183fe9-8458-8a7f-2b8e-1c38666b6399@redhat.com>
Date:   Mon, 29 Aug 2022 11:24:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: cgroups v2 cpuset partition bug
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>,
        =?UTF-8?B?TWF4aW0g4oCcTUFYUEFJTuKAnSBNYWth?= =?UTF-8?Q?rov?= 
        <maxpain177@gmail.com>
Cc:     cgroups@vger.kernel.org
References: <C98773C9-F5ED-4664-BED1-5C03351130D4@gmail.com>
 <YwT/BNqIdCEyUpFR@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YwT/BNqIdCEyUpFR@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/23/22 12:23, Tejun Heo wrote:
> (cc'ing Waiman for visibilty)
>
> On Tue, Aug 23, 2022 at 03:13:30PM +0300, Maxim “MAXPAIN” Makarov wrote:
>> Hello. I have no idea where I can ask questions about cgroups v2. I have a problem with cpuset partitions.
>> Could you please, check this question?
>> https://unix.stackexchange.com/questions/714454/cgroups-v2-cpuset-doesnt-take-an-effect-without-process-restart

When a partition is created, the cpuset code will update the cpu 
affinity of the tasks in the parent cpuset using update_tasks_cpumask(). 
This function will set the new cpu affinity for those tasks and move it 
over to the new cpus. However, if the tasks aren't running at the time, 
the move may be delayed until those tasks are waken up. The fact the 
task affinity is correct means that the cpuset code has done the right 
thing.

I am not sure what tool do you use to check the task's cpus. I believe 
the tool may show what cpu the task is previously running on. It does 
not means the the task will run on that cpu when it is waken up. It is 
only a bug if the task is running and it is on the wrong cpu.

Cheers,
Longman

