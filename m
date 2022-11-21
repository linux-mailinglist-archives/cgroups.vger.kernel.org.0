Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2BD632CAF
	for <lists+cgroups@lfdr.de>; Mon, 21 Nov 2022 20:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiKUTMh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Nov 2022 14:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiKUTMG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Nov 2022 14:12:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796EBD2DEC
        for <cgroups@vger.kernel.org>; Mon, 21 Nov 2022 11:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669057871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pCmAWoY/E+D1EdQWKofo3IS5cplA0bKml9JOCiXWhTQ=;
        b=P8yOsBNsJms5T9BTfHTQbcQdN5NkdVgbRcJ9HAw38mOr0lh7l5iNrTeN4QJau6EEfggqfH
        Oxdd4YoLT8b39Y1DYa+AHBOLciS5bSCa6A7ZL1RJHffqpvZ4l8JG8XWQQecYBN2QqZ4KFf
        5HLv0o+qNQjOZG/Tu/eknzwUhsyOgdY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-MChxLxSOMvCXjIztijKxCw-1; Mon, 21 Nov 2022 14:11:06 -0500
X-MC-Unique: MChxLxSOMvCXjIztijKxCw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B455D811E84;
        Mon, 21 Nov 2022 19:11:03 +0000 (UTC)
Received: from [10.22.33.92] (unknown [10.22.33.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45FFA49BB60;
        Mon, 21 Nov 2022 19:11:03 +0000 (UTC)
Message-ID: <78de73b0-2a27-592b-b70b-ca209962fdef@redhat.com>
Date:   Mon, 21 Nov 2022 14:11:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/2] cgroup/cpuset: Optimize cpuset_attach() on v2
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20221112221939.1272764-1-longman@redhat.com>
 <20221112221939.1272764-3-longman@redhat.com>
 <20221121185042.GA15225@blackbody.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221121185042.GA15225@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 11/21/22 13:50, Michal Koutný wrote:
> On Sat, Nov 12, 2022 at 05:19:39PM -0500, Waiman Long <longman@redhat.com> wrote:
>> +	/*
>> +	 * In the default hierarchy, enabling cpuset in the child cgroups
>> +	 * will trigger a number of cpuset_attach() calls with no change
>> +	 * in effective cpus and mems. In that case, we can optimize out
>> +	 * by skipping the task iteration and update.
>> +	 */
>> +	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
>> +	    !cpus_updated && !mems_updated) {
> I'm just wondering -- why is this limited to the default hierarchy only?
> IOW why can't v1 skip too (when favorable constness between cpusets).

Cpuset v1 is a bit more complex. Besides cpu and node masks, it also 
have other flags like the spread flags that we need to looks for 
changes. Unlike cpuset v2, I don't think it is likely that 
cpuset_attach() will be called without changes in cpu and node masks. 
That are the reason why this patch focuses on v2. If it is found that 
this is not the case, we can always extend the support to v1.

Cheers,
Longman

