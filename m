Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5B845188A
	for <lists+cgroups@lfdr.de>; Mon, 15 Nov 2021 23:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243146AbhKOXBp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Nov 2021 18:01:45 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52296 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbhKOW7p (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Nov 2021 17:59:45 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3B629212FE;
        Mon, 15 Nov 2021 22:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637017007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XszfChHIbqmWBDL5Op+W4Hd9f4QflFXocWVFOOOOktk=;
        b=1e6O/P+WZWOtrccWiDyT36Q+3aR4OOPIZKKbLnfHJzxJpn0yd9vzpSEglewY8CaiUv+3pU
        9mlryOi2Vca75FOJA7sIeNmH8Yo0m894mMQXymeHo7rOASJlMo90k5hNjf+zdYSOJ1EKjd
        o9jX6MLbrlePfiFrRPDtiAWALFDIYBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637017007;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XszfChHIbqmWBDL5Op+W4Hd9f4QflFXocWVFOOOOktk=;
        b=g5eanP5cV7Lgt+mSe5VdHWMrEK+GoUSwzJlHsUfkKY+wdapf2u7w8IgsvOI2M6kt4Mz8eO
        fAWig/ra+NWOOgAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B04013B26;
        Mon, 15 Nov 2021 22:56:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GzoGAa/lkmF9QQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 15 Nov 2021 22:56:47 +0000
Message-ID: <abe4ef63-7bb2-93c2-d0c7-d7bab9ba2f6b@suse.cz>
Date:   Mon, 15 Nov 2021 23:56:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] mm: slab: make slab iterator functions static
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211109133359.32881-1-songmuchun@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211109133359.32881-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/9/21 14:33, Muchun Song wrote:
> There is no external users of slab_start/next/stop(), so make them
> static. And the memory.kmem.slabinfo is deprecated, which outputs
> nothing now, so move memcg_slab_show() into mm/memcontrol.c and
> rename it to mem_cgroup_slab_show to be consistent with other
> function names.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
