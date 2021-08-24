Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897C13F5E85
	for <lists+cgroups@lfdr.de>; Tue, 24 Aug 2021 15:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbhHXNCn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Aug 2021 09:02:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56630 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbhHXNCn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Aug 2021 09:02:43 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0BBF71FD7E;
        Tue, 24 Aug 2021 13:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629810118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gwH5bbr1n2NZef7C9Wwr43FBq6nYcyZU+iVjKru+rro=;
        b=Zphsll3UPQ8JZnXmkRt+VpNc5eh3bi0B29d1VWjPCEuibIhHnPN6iZfH5RD5r6ehB311i2
        1lmvIysI56YO3YycS2hsn4QTO6ylJyEAVYR38Q/Cqi/qREqfvIwCBG2ypjRSJukQz24vLT
        8Lwj7blexzosNMuZrwtcRpBAxnDHAFk=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D679313A55;
        Tue, 24 Aug 2021 13:01:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id e3FnM8XtJGHfLgAAGKfGzw
        (envelope-from <mkoutny@suse.com>); Tue, 24 Aug 2021 13:01:57 +0000
Date:   Tue, 24 Aug 2021 15:01:56 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Leon Yang <lnyng@fb.com>, Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: fix occasional OOMs due to proportional
 memory.low reclaim
Message-ID: <20210824130156.GB7802@blackbody.suse.cz>
References: <20210817180506.220056-1-hannes@cmpxchg.org>
 <YSPIOZOVG2qplLIW@blackbook>
 <YSPfe4yf2fRdzijh@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSPfe4yf2fRdzijh@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 23, 2021 at 01:48:43PM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
> Note that this isn't new behavior.

Understood, there may be a difference between:
a) a cgroup where the protected reserve was detected (this changed),
b) a cgroup where the protected memory is reclaimed.

> "The number of times the cgroup's memory.low-protected memory was
> reclaimed in order to avoid OOM during high memory pressure."

Yes, this is what I meant (i.e. events for the case b) above).

Michal
