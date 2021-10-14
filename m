Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E923D42D59D
	for <lists+cgroups@lfdr.de>; Thu, 14 Oct 2021 11:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhJNJGN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Oct 2021 05:06:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60330 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhJNJGN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Oct 2021 05:06:13 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 899BA21A76;
        Thu, 14 Oct 2021 09:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634202247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lu12yO1VBRDo6VgSvac2BSrF4pgu+g9lquRIF7SLSvU=;
        b=LxA2lYm8DFK5I+Ih+5z2NdWuDvzhjnkebYh3JxYl4ebEJ3ItNSkOB/BILlLXSYlHJuW6MZ
        QJ1PXOanVyHcyZw2ORTbNI0qLl/mbSDt+Wr8zbEEYrPgZCPhCxif9PFVOK03U1NqDlYpM1
        Mg+HGBov+6qE3UB/TTCnohFyupV/o2M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 738D313E60;
        Thu, 14 Oct 2021 09:04:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sC64G4fyZ2FvTQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 14 Oct 2021 09:04:07 +0000
Date:   Thu, 14 Oct 2021 11:04:06 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] memcg: unify memcg stat flushing
Message-ID: <20211014090406.GA62649@blackbody.suse.cz>
References: <20211001190040.48086-1-shakeelb@google.com>
 <20211001190040.48086-2-shakeelb@google.com>
 <20211013180122.GA1007@blackbody.suse.cz>
 <CALvZod6dN5Ub-r9+evXYCaeNuzrDs1byPLY1DAyn=R7rqHoqKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6dN5Ub-r9+evXYCaeNuzrDs1byPLY1DAyn=R7rqHoqKg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 13, 2021 at 12:24:31PM -0700, Shakeel Butt <shakeelb@google.com> wrote:
> 1) The periodic async flush will keep the update tree small and will
> keep infrequent readers cheap.
> 2) Keep things simple for now and come back if someone complains for
> very frequent stats readers.

OK, understood.

Michal
