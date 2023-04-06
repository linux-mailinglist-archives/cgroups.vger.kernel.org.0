Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50106D9CCD
	for <lists+cgroups@lfdr.de>; Thu,  6 Apr 2023 17:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239417AbjDFPyX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Apr 2023 11:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239437AbjDFPyX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Apr 2023 11:54:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F3A4220
        for <cgroups@vger.kernel.org>; Thu,  6 Apr 2023 08:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680796410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DfBJz2JCY2tXUX/6IQuIUiWHj7GX2hI633TNpoPdRVg=;
        b=iJXAJg0pIW3H3IBC0qDdWciCvDPCu2LQPLdp2k7Vl5mPLU6ZGy0PuO7ybEEsTfKsGJWk8I
        WFV3grPtkC1vXzEGnq3b28b1sJDumwTqK2nf6snkiKJYVFQp9281ZXgHmQBE3riS+Mk9Yi
        5do+dSxDSep/Nh6EN43jmeDBwj8FJLs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-1KkVPaiCOyyfOjc6vZNExA-1; Thu, 06 Apr 2023 11:53:28 -0400
X-MC-Unique: 1KkVPaiCOyyfOjc6vZNExA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55660101A551;
        Thu,  6 Apr 2023 15:53:28 +0000 (UTC)
Received: from [10.22.9.26] (unknown [10.22.9.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BF472166B26;
        Thu,  6 Apr 2023 15:53:27 +0000 (UTC)
Message-ID: <36b96b9c-d08a-e97c-05ff-152d671880e6@redhat.com>
Date:   Thu, 6 Apr 2023 11:53:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] mm: oom: introduce cpuset oom
Content-Language: en-US
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     rientjes@google.com, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
References: <20230404115509.14299-1-ligang.bdlg@bytedance.com>
 <ZCw0sR6IqYa5Es7Q@dhcp22.suse.cz>
 <342c1967-8a68-275c-042e-765d5993157c@redhat.com>
 <cc77d706-7baf-951b-13a5-3470c2b1bba9@bytedance.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <cc77d706-7baf-951b-13a5-3470c2b1bba9@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 4/6/23 09:02, Gang Li wrote:
> On 2023/4/5 01:24, Waiman Long wrote:
>>
>> You will also need to take cpuset_rwsem to make sure that cpusets are 
>> stable. BTW, the cpuset_cgroup_scan_tasks() name is kind of 
>> redundant. I will suggest you just name it as cpuset_scan_tasks(). 
>> Please also add a 
>
> mem cgroup oom use `mem_cgroup_scan_tasks`.
> How about keep `cpuset_cgroup_scan_tasks` for naming consistency?

The "memory cgroup" term is used to identify the code related to memory 
cgroup controller. Cpuset, on the other hand, is a well known cgroup 
controller. Cpuset cgroup is not a term that people will normally use.  
That is why this name is awkward.

Cheers,
Longman

