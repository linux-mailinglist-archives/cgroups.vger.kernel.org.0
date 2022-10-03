Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964315F33EE
	for <lists+cgroups@lfdr.de>; Mon,  3 Oct 2022 18:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJCQzj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Oct 2022 12:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiJCQzg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Oct 2022 12:55:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C24726AD7
        for <cgroups@vger.kernel.org>; Mon,  3 Oct 2022 09:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664816128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tbuz3qR+hD453Hh1mWG4NdV8SaaNv0Mi9FQnyaBvNcQ=;
        b=b/bQp0TKTdQUPHmntzH7Tzl90QqzT9MyHjf484vn4ZKeEb386mRRmwWmPkFOpCJqNVWMBj
        DCkHqTBOXdxikLECZyl8/Ki2C2wc2xhHEIOOJY9wvM3HeyPtkX9Hw0cjRzLSLKzC86/EE1
        TkMyPeu9lPodRXSugSn5UeAwTLNMfyc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-tW49eZCKPO6FsA_Uubjt3w-1; Mon, 03 Oct 2022 12:55:25 -0400
X-MC-Unique: tW49eZCKPO6FsA_Uubjt3w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD8BB3804061;
        Mon,  3 Oct 2022 16:55:24 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5720E492B04;
        Mon,  3 Oct 2022 16:55:24 +0000 (UTC)
Message-ID: <006ebc52-ab37-442a-9ba3-e7b8dff53fab@redhat.com>
Date:   Mon, 3 Oct 2022 12:55:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v7 1/3] llist: Add a lock-less list variant terminated by
 a sentinel node
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20221003154459.207538-1-longman@redhat.com>
 <20221003154459.207538-2-longman@redhat.com>
 <YzsQZPONIJRgtf3o@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YzsQZPONIJRgtf3o@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 10/3/22 12:40, Tejun Heo wrote:
> Hello, Waiman.
>
> On Mon, Oct 03, 2022 at 11:44:57AM -0400, Waiman Long wrote:
>> The lock-less list API is useful for dealing with list in a lock-less
>> manner. However, one of the drawback of the current API is that there
>> is not an easy way to determine if an entry has already been put into a
>> lock-less list. This has to be tracked externally and the tracking will
>> not be atomic unless some external synchronization logic is in place.
>>
>> This patch introduces a new variant of the lock-less list terminated
>> by a sentinel node instead of by NULL. The function names start with
>> "sllist" instead of "llist". The advantage of this scheme is that we
>> can atomically determine if an entry has been put into a lock-less
>> list by looking at the next pointer of the llist_node. Of course, the
>> callers must clear the next pointer when an entry is removed from the
>> lockless list. This is done automatically when the sllist_for_each_safe
>> or sllist_for_each_entry_safe iteraters are used. The non-safe versions
>> of sllist iterator are not provided.
> Any chance we can add sentinel to the existing llist instead of creating a
> new variant? There's no real downside to always using sentinel, right?

That was my original plan. However, after looking at some existing users 
of lockless list, they have coded in the dependency on the fact that a 
lockless list is empty if it is NULL. I guess I can make this true also 
for the new lockless list with sentinel at the expense of a bit more 
overhead in the entry insertion path and deletion path. I will take a 
further look at that.

Cheers,
Longman

