Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CC85F34AF
	for <lists+cgroups@lfdr.de>; Mon,  3 Oct 2022 19:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiJCRkj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Oct 2022 13:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJCRkR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Oct 2022 13:40:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7971A81D
        for <cgroups@vger.kernel.org>; Mon,  3 Oct 2022 10:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664818813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/OvRUrGfw8TOZah0PxNYChSkH0fCR+iXG8NZ//kOXLc=;
        b=GLvw4/8Md/ka9eC21uvQhKfX1eSQGuBdPVW0qGYFm6JV2A05J2Fbo5W5s5rNn6w5vN6vpq
        mb4eRanNfv5av0MfhqBIcLUqOi5KaZ5PO2zbTTiAvEaZyZRYg3miU3NUH18JXI1gJu8/od
        OKdxELzuP9ss///g2MtEh9GfyJU+puk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-CREGx1c3NwWpx7R3TydlWQ-1; Mon, 03 Oct 2022 13:40:06 -0400
X-MC-Unique: CREGx1c3NwWpx7R3TydlWQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1584C80C8C1;
        Mon,  3 Oct 2022 17:40:06 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B89AA492CA2;
        Mon,  3 Oct 2022 17:40:05 +0000 (UTC)
Message-ID: <87e7cd70-4ab6-f33b-ce26-afe2c7c04faa@redhat.com>
Date:   Mon, 3 Oct 2022 13:40:05 -0400
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
 <006ebc52-ab37-442a-9ba3-e7b8dff53fab@redhat.com>
 <YzsUgY4CC0SH8Sl2@slm.duckdns.org>
 <8008933b-4a28-19e5-02db-ef1d07eaf952@redhat.com>
 <YzsdsjlMMDFwLOzR@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YzsdsjlMMDFwLOzR@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 10/3/22 13:36, Tejun Heo wrote:
> Hello,
>
> On Mon, Oct 03, 2022 at 01:32:49PM -0400, Waiman Long wrote:
>> What my current thinking is to make llist works with both NULL and sentinel
>> terminated lockless list. Users who wish to use the sentinel terminated
>> version will have to use special sentinel version of LLIST_HEAD() macro and
>> llist_del_all() and __llist_del_all() functions. In this way, I don't need
>> to touch an existing users of llist while minimizing code redundancy. What
>> do you think?
> Wouldn't that be more error-prone in the long term? I'd just bite the bullet
> and convert the empty tests. It is a hassle to find them but given that it's
> just the head node testing, it hopefully wouldn't be too bad.

OK, I will take a further look at what changes will be needed by the 
existing llist users.

Thanks,
Longman

