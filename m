Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08ACA4AC9B6
	for <lists+cgroups@lfdr.de>; Mon,  7 Feb 2022 20:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbiBGTgd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Feb 2022 14:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240683AbiBGTeM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Feb 2022 14:34:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 433F3C0401DA
        for <cgroups@vger.kernel.org>; Mon,  7 Feb 2022 11:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644262451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mt0dY24O8oy81HO9eljR8ZyBXQGPacTP1E1VhcVXUbE=;
        b=gZBkxxMJizo3mPCjQT6YvqGdeTOzA7uAmfYRANSXAsOMj0gATDhucQSGsHRYkuxUqLaP1w
        YHoPGae+RVQnq5mhxM3QWWCh/fFuzoQLpjDetw59EmWq6mNms+9UJT9rxi6qUfgUo0CjIr
        GKR11xdo1r8HBzpYWVtQFA+dl9hC50w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-aVSMeVKxOSmcoeJFlsExTA-1; Mon, 07 Feb 2022 14:34:08 -0500
X-MC-Unique: aVSMeVKxOSmcoeJFlsExTA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E2761898291;
        Mon,  7 Feb 2022 19:34:05 +0000 (UTC)
Received: from [10.22.32.15] (unknown [10.22.32.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDA3A452E6;
        Mon,  7 Feb 2022 19:33:57 +0000 (UTC)
Message-ID: <53f89ef2-3894-ad23-7484-38ce192bce20@redhat.com>
Date:   Mon, 7 Feb 2022 14:33:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 3/4] mm/page_owner: Print memcg information
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <guro@fb.com>, Rafael Aquini <aquini@redhat.com>
References: <20220131192308.608837-5-longman@redhat.com>
 <20220202203036.744010-4-longman@redhat.com>
 <YfvOp5VXrxy9IW1w@dhcp22.suse.cz>
 <3f042edb-3769-afea-17a7-899578cd5c69@redhat.com>
 <YgFUxFI5bMbc42j4@dhcp22.suse.cz>
 <20220207110947.f07b58898d91c02090f9aacf@linux-foundation.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220207110947.f07b58898d91c02090f9aacf@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 2/7/22 14:09, Andrew Morton wrote:
> On Mon, 7 Feb 2022 18:20:04 +0100 Michal Hocko <mhocko@suse.com> wrote:
>
>> On Thu 03-02-22 14:03:58, Waiman Long wrote:
>>> On 2/3/22 07:46, Michal Hocko wrote:
>>>> On Wed 02-02-22 15:30:35, Waiman Long wrote:
>>>> [...]
>> ...
>>>>> +	online = (memcg->css.flags & CSS_ONLINE);
>>>>> +	cgroup_name(memcg->css.cgroup, name, sizeof(name));
>>>> Is there any specific reason to use another buffer allocated on the
>>>> stack? Also 80B seems too short to cover NAME_MAX.
>>>>
>>>> Nothing else jumped at me.
>>> I suppose we can print directly into kbuf with cgroup_name(), but using a
>>> separate buffer is easier to read and understand. 79 characters should be
>>> enough for most cgroup names. Some auto-generated names with some kind of
>>> embedded uuids may be longer than that, but the random sequence of hex
>>> digits that may be missing do not convey much information for identification
>>> purpose. We can always increase the buffer length later if it turns out to
>>> be an issue.
>> Cutting a name short sounds like a source of confusion and there doesn't
>> seem to be any good reason for that.
> Yes.  If we give them 79 characters, someone will go and want 94.  If
> we can prevent this once and for ever, let's please do so.

Sure. Will send a version with that change.

Cheers,
Longman

>

