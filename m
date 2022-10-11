Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0215FB907
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 19:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJKRPI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Oct 2022 13:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiJKRPF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Oct 2022 13:15:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3462D3718B
        for <cgroups@vger.kernel.org>; Tue, 11 Oct 2022 10:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665508504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MnvCQgz6H0YpLOGZ3RFU26i2x7EAPQhf8onHHyzectI=;
        b=OqcpOaijhtf4UMDVEYBCIrc0/XMa75pUroAcSrrVHb0rpgJnkbglmUB2Saa7hf/d2buAFX
        ttBFDhfNTX8k6S+z4nkG3ufN4BgjC7mw5AFFwJTobgBeXgUcjexx1HARe9eE5hV1sqFxe/
        KgiWzJFD68nSoI11gaa6+Gsmvp88/u8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-fhvcurG1PIO_86zyIJwZNw-1; Tue, 11 Oct 2022 13:15:00 -0400
X-MC-Unique: fhvcurG1PIO_86zyIJwZNw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41E6F38041CC;
        Tue, 11 Oct 2022 17:15:00 +0000 (UTC)
Received: from [10.22.17.56] (unknown [10.22.17.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D1F740E992A;
        Tue, 11 Oct 2022 17:14:59 +0000 (UTC)
Message-ID: <b79d7f33-77b8-f200-5acd-1f3e5e37d00d@redhat.com>
Date:   Tue, 11 Oct 2022 13:14:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] mm/memcontrol: Don't increase effective low/min if no
 protection needed
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Chris Down <chris@chrisdown.name>
References: <20221011143015.1152968-1-longman@redhat.com>
 <Y0WOPZxWSnUjzZ8e@dhcp22.suse.cz>
 <defdb421-342e-ebcb-d7f0-005559dd1e0d@redhat.com>
 <Y0WiIDmPPXYZuHpX@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y0WiIDmPPXYZuHpX@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 10/11/22 13:04, Tejun Heo wrote:
> On Tue, Oct 11, 2022 at 01:00:22PM -0400, Waiman Long wrote:
>> You are right about that. An alternative way to address this issue is to
>> disable memory low event when memory.low isn't set. An user who want to
>> track memory.low event has to set it to a non-zero value. Would that be
>> acceptable?
> Wouldn't it make sense to fix the test? With recursive_prot on, the cgroup
> actually is under low protection and it seems like the correct behavior is
> to report the low events accordingly.

Yes, that is another possible way of looking at that problem. Will talk 
to our QE people of doing that.

Thanks,
Longman

