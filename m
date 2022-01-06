Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A21485D3E
	for <lists+cgroups@lfdr.de>; Thu,  6 Jan 2022 01:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343876AbiAFAgA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Jan 2022 19:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343878AbiAFAfp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Jan 2022 19:35:45 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B939C06118C;
        Wed,  5 Jan 2022 16:35:45 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z9so3025370edm.10;
        Wed, 05 Jan 2022 16:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cGAzTbWX9bWY3ictCjgA8akddhtFPaclmkpNp73lsao=;
        b=q7mMbkzjeK1zBEQMn6eLSgiX7Z8jq4kGR6m+fJD9lToHZcbEEjkLla6ISvICWYSxHO
         cTwifW0ABF+IdxL0ETd+ZZnhN+V/ZPVPbIt7H4kAPHpbrPdysuNTellN9I6OTiWCuZkC
         e6VA9zt46eJQETKvBl6bpqNb/T2I6UiYO+ZQALwPfr4UNoujIEObeZ20Fx0f+nQZ7pRj
         gq6qB7cfiN8ERC6gflGtPL8NEIhhiAqweSgnzo8S0hy5yANX52M3pesMr1+bRulnWWBU
         YjejqAibkBxWyWqtr3OumMmyOGWyU2Vlu8WbjezChpIZ0cqRM6f1ZDB5lqGHqkO2z2Bb
         x96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cGAzTbWX9bWY3ictCjgA8akddhtFPaclmkpNp73lsao=;
        b=EFcOtsKBfwKePmRY6yUWNQBunqi/SPmD2ntT929estmp//fdHa2vLEKTV8D86CndYY
         Vw5JfodebpbpW1l/kHt4HRA8D00pRJLat9FORbZ7XuEtmXHzYfprNDbD7lQxx8fa/BQC
         CSLto0tP07P2lTWU0foBHtc5kpnt8ftctWMIYhJoyJ7UL571dneOeUA0i6S4Me3R0jbp
         44PM6APDsz8KOE4ndp3gOmhg4h+b6oqiKujd54fkndLPGAZPtOrRQfR0V3cyOeDol0fw
         aLOdiMM0qmUuH75okthIJNe03r4rPdHpmKXe648W/QzZ7y0J8/47wQ66gqqP7gTQf1Ee
         Mx8Q==
X-Gm-Message-State: AOAM533/OjG0GLim+U/USekysNDbOD9D8eOID3HqdAKCOn2BNdap+fSQ
        jIFwsi5deMbsfkYGMx7VhVYMPfI078k=
X-Google-Smtp-Source: ABdhPJzrOsaOHSMP2MVhk1PrisIvQOkzxOmx8Bcy4Kn9UwzlDI0qZofzQbm+PBBVDUgCmEQAI3qgQw==
X-Received: by 2002:a17:906:4e46:: with SMTP id g6mr2286653ejw.366.1641429343275;
        Wed, 05 Jan 2022 16:35:43 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 1sm94642ejw.175.2022.01.05.16.35.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jan 2022 16:35:42 -0800 (PST)
Date:   Thu, 6 Jan 2022 00:35:42 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Koutn? <mkoutny@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cgroup/rstat: check updated_next only for root
Message-ID: <20220106003542.d247w7qwtq6ajyii@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20211225000932.7253-1-richard.weiyang@gmail.com>
 <20211225000932.7253-2-richard.weiyang@gmail.com>
 <20220105193504.GD6464@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105193504.GD6464@blackbody.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 05, 2022 at 08:35:04PM +0100, Michal Koutn? wrote:
>On Sat, Dec 25, 2021 at 12:09:32AM +0000, Wei Yang <richard.weiyang@gmail.com> wrote:
>> This means we can remove the check on ->updated_next, if we make sure
>> the subtree from @root is on list, which could be done by checking
>> updated_next for root.
>
>Nice refactoring.
>
>> @@ -96,9 +97,12 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
>>  	 * We're gonna walk down to the first leaf and visit/remove it.  We
>>  	 * can pick whatever unvisited node as the starting point.
>>  	 */
>> -	if (!pos)
>> +	if (!pos) {
>>  		pos = root;
>> -	else
>> +		// return NULL if this subtree is not on-list
>> +		if (!cgroup_rstat_cpu(pos, cpu)->updated_next)
>> +			return NULL;
>> +	} else
>+		/* return NULL if this subtree is not on-list */
>
>Just a coding style nitpick.

Thanks for comment. Would you like me to send a v2?

>
>The patch is otherwise
>Reviewed-by: Michal Koutn? <mkoutny@suse.com>

-- 
Wei Yang
Help you, Help me
