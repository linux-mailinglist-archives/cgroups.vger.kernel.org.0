Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BABE77FC51
	for <lists+cgroups@lfdr.de>; Thu, 17 Aug 2023 18:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353721AbjHQQqo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Aug 2023 12:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353779AbjHQQqc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Aug 2023 12:46:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C29C2724
        for <cgroups@vger.kernel.org>; Thu, 17 Aug 2023 09:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692290748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EMYB6Aa88h1ABn1kG37sttadyKX0sLxsWeo4W40AHWI=;
        b=jAdGgx0LRWhvNObkUL98YU4pzCMemWpjhXVMCl3dGob4mTnb6QGg20QSMoQP5PGW5DWx+r
        6NLyPB6xy44dPIHqq7TpBy0fYedZtdaLDHNUr1yFTjIEebhJeThJdD2gPRlFa1/IDKBKjH
        5VFjW8PR2JVYCJudcgIJGYLQSlXx2CA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-OlgnDsRfM5yPWAcN0xI3sg-1; Thu, 17 Aug 2023 12:45:44 -0400
X-MC-Unique: OlgnDsRfM5yPWAcN0xI3sg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B63C6801CF3;
        Thu, 17 Aug 2023 16:45:43 +0000 (UTC)
Received: from [10.22.16.215] (unknown [10.22.16.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 644A1C15BAD;
        Thu, 17 Aug 2023 16:45:43 +0000 (UTC)
Message-ID: <0aa69b7b-8955-f495-0026-8c83597a4739@redhat.com>
Date:   Thu, 17 Aug 2023 12:45:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4] mm: oom: introduce cpuset oom
Content-Language: en-US
To:     Gang Li <gang.li@linux.dev>, Michal Hocko <mhocko@suse.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org, rientjes@google.com,
        Zefan Li <lizefan.x@bytedance.com>,
        linux-kernel@vger.kernel.org
References: <20230411065816.9798-1-ligang.bdlg@bytedance.com>
 <ZDVwaqzOBNTpuR1w@dhcp22.suse.cz>
 <9ba0de31-b9b8-fb10-011e-b24e9dba5ccd@linux.dev>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <9ba0de31-b9b8-fb10-011e-b24e9dba5ccd@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/17/23 04:40, Gang Li wrote:
>
> Since __GFP_HARDWALL is set as long as cpuset is enabled, I think we can
> use it to determine if we are under the constraint of CPUSET.
>
> But I have a question: Why we always set __GFP_HARDWALL when cpuset is
> enabled, regardless of the value of cpuset.mem_hardwall?

There is no direct dependency between cpuset.mem_hardwall and the 
__GFP_HARDWALL flag. When cpuset is enabled, all user memory allocation 
should be subjected to the cpuset memory constraint. In the case of 
non-user memory allocation, it can fall back to to the node mask of an 
ancestor up to the root cgroup, i.e. all memory nodes. 
cpuset.mem_hardwall enables a barrier to this upward search.

Note that cpuset.mem_hardwall is a v1 feature that is not available in 
cgroup v2.

Cheers,
Longman

