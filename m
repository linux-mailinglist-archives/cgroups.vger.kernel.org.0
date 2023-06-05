Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BE47229D5
	for <lists+cgroups@lfdr.de>; Mon,  5 Jun 2023 16:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbjFEOww (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Jun 2023 10:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbjFEOwm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Jun 2023 10:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDF7F1
        for <cgroups@vger.kernel.org>; Mon,  5 Jun 2023 07:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685976718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+jSjkiDWclAj9vqdgMGMiyGqF2MyWCPc8BsnONjQCIE=;
        b=YFJ9xfSSdQdjIJ/DQ6BUcjAtOT3IsQvhoxvWFfgjXSTcmfom1kDzuF7jYNGC/o70ut9oIj
        CsD/qfPKETAiJ3IO4qv700/wlh7ODa9MTP8NZ9EMPAAzwjcCE+Alzvh+e7N/a9x/gbOjr5
        BqOmaAohg5e3YDk5LpO42XXdojO0iY0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-91-SdmlhM5mxTz-A4IjhQA-1; Mon, 05 Jun 2023 10:51:52 -0400
X-MC-Unique: 91-SdmlhM5mxTz-A4IjhQA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F4EA381D4CA;
        Mon,  5 Jun 2023 14:51:51 +0000 (UTC)
Received: from [10.22.10.186] (unknown [10.22.10.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC1A748205E;
        Mon,  5 Jun 2023 14:51:50 +0000 (UTC)
Message-ID: <177cc1f5-3b11-cde1-5769-f18e87890083@redhat.com>
Date:   Mon, 5 Jun 2023 10:51:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] cgroup: fixed the cset refcnt leak when fork() failed
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Zou Cao <zoucaox@gmail.com>, linux-kernel@vger.kernel.org,
        tj@kernel.org
Cc:     cgroups@vger.kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, brauner@kernel.org,
        Zou Cao <zoucao@kuaishou.com>
References: <20230605130444.1421-1-zoucao@kuaishou.com>
 <e0d1998f-c081-30e6-7646-cf6460c2d67c@redhat.com>
In-Reply-To: <e0d1998f-c081-30e6-7646-cf6460c2d67c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 6/5/23 10:12, Waiman Long wrote:
>> kernel/cgroup/cgroup.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index d18c2ef..5ecd706 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -6284,6 +6284,11 @@ void cgroup_cancel_fork(struct task_struct 
>> *child,
>>           if (ss->cancel_fork)
>>               ss->cancel_fork(child, kargs->cset);
>>   +    if (!(kargs->flags & CLONE_INTO_CGROUP) &&
>> +            kargs->cset) {
>> +        put_css_set(kargs->cset);
>> +    }
>> +
> I believe the out_revert error path of cgroup_can_fork() has a similar 
> issue. Perhaps you may want to put the put_css_set() call in 
> cgroup_css_set_put_fork().

Sorry, it should not be done in cgroup_css_set_put_fork(). As the 
increase in reference is properly matched in css_post_fork(). That means 
similar change will be needed in cgroup_can_fork().

Cheers,
Longman

