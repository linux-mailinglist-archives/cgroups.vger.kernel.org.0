Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A944A8398
	for <lists+cgroups@lfdr.de>; Thu,  3 Feb 2022 13:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240219AbiBCMKp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Feb 2022 07:10:45 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37358 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236936AbiBCMKp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Feb 2022 07:10:45 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 12B3821100;
        Thu,  3 Feb 2022 12:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643890244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=osIhrdtOjjmkFFphcb83Nczt+7vGIRa7d6OObVoINEs=;
        b=VhapAhebHkYqVU+ErQEcL6KulK37k5BjSG1CLIDdCh/yTExSO04ZuZymV71zPilFsdgOfA
        wF2ZIVe+bnEC36RO81mRv65injO9CyFWPGm8vITJPbRh2wAkyrrqLKGNBjicMVuBQXTMT+
        eB52FxaQGUmLUFtnHKdRV5Tx2v81Fyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643890244;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=osIhrdtOjjmkFFphcb83Nczt+7vGIRa7d6OObVoINEs=;
        b=nnKKymePe6Gbn1kwuKkf/SJxV5DxbzCLpIFF/YkxH57g/HA2GqJLuip3Rn+iSZxEe0CZM6
        Tqir+aIs1KACZyDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C178913BAD;
        Thu,  3 Feb 2022 12:10:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lDJtLkPG+2GBDgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 03 Feb 2022 12:10:43 +0000
Message-ID: <91fb8637-6550-dc37-a95b-df7812b02b0a@suse.cz>
Date:   Thu, 3 Feb 2022 13:10:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 4/4] mm/page_owner: Record task command name
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>, Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
 <20220131220328.622162-1-longman@redhat.com>
 <YflRjeoC0jbzArDG@dhcp22.suse.cz>
 <4ba66abe-5c6d-26a7-f11c-c3b8514bfb34@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <4ba66abe-5c6d-26a7-f11c-c3b8514bfb34@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/2/22 17:53, Waiman Long wrote:
> 
> On 2/1/22 10:28, Michal Hocko wrote:
>> Cc Vlastimil
>>
>> On Mon 31-01-22 17:03:28, Waiman Long wrote:
>>> The page_owner information currently includes the pid of the calling
>>> task. That is useful as long as the task is still running. Otherwise,
>>> the number is meaningless. To have more information about the allocating
>>> tasks that had exited by the time the page_owner information is
>>> retrieved, we need to store the command name of the task.
>>>
>>> Add a new comm field into page_owner structure to store the command name
>>> and display it when the page_owner information is retrieved.
>> I completely agree that pid is effectivelly useless (if not misleading)
>> but is comm really telling all that much to compensate for the
>> additional storage required for _each_ page in the system?
> 
> Yes, it does add an extra 16 bytes per page overhead. The command name can
> be useful if one want to find out which userspace command is responsible for
> a problematic page allocation. Maybe we can remove pid from page_owner to
> save 8 bytes as you also agree that this number is not that useful.

Pid could be used to correlate command instances (not perfectly if reuse
happens), but command name could have a higher chance to be useful. In my
experience the most useful were the stacktraces and gfp/order etc. anyway.
So I wouldn't be opposed replacing pid with comm. The mild size increase
should be acceptable, this is an opt-in feature for debugging sessions with
known tradeoff for memory and cpu overhead for the extra info.

> Cheers,
> Longman
> 

