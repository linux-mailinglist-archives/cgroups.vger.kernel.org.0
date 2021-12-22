Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D366247D434
	for <lists+cgroups@lfdr.de>; Wed, 22 Dec 2021 16:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343686AbhLVPVG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Dec 2021 10:21:06 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58204 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237912AbhLVPVF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Dec 2021 10:21:05 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7C6AD210FC;
        Wed, 22 Dec 2021 15:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640186464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R2sITC9btmJiDozWSszdfDjZ963CmDEzfUkTeAu2sDA=;
        b=lSydeBHpVZNddXzbAHVcSnrorz4RUGeFU9TcqTystRoY8fF+TifMIFhPIbsaOAgxucV4jH
        zByyb3oanWZ2gfcPt92euWMf29KSEzeuCqXI6nDgizZMzcW4ceOYs5GsEQ0DzspIlFnyqf
        n4sZ65IcXVyMyQKC/vMKEDCme6BoN5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640186464;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R2sITC9btmJiDozWSszdfDjZ963CmDEzfUkTeAu2sDA=;
        b=xhFZ8ktwWymeyjzUUyYj7R5bM5dB3ZApam1ek0CcfrhdfzMc9J977sTd3qNZWCMtqfvUsi
        irLLy6oQ51UHRECQ==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 6D581A3B88;
        Wed, 22 Dec 2021 15:21:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 03C951F2CEF; Wed, 22 Dec 2021 16:21:03 +0100 (CET)
Date:   Wed, 22 Dec 2021 16:21:03 +0100
From:   Jan Kara <jack@suse.cz>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Jan Kara <jack@suse.cz>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, fvogt@suse.de, cgroups@vger.kernel.org
Subject: Re: Use after free with BFQ and cgroups
Message-ID: <20211222152103.GF685@quack2.suse.cz>
References: <20211125172809.GC19572@quack2.suse.cz>
 <20211126144724.GA31093@blackbody.suse.cz>
 <20211129171115.GC29512@quack2.suse.cz>
 <f03b2b1c-808a-c657-327d-03165b988e7d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f03b2b1c-808a-c657-327d-03165b988e7d@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 09-12-21 10:23:33, yukuai (C) wrote:
> We confirmed this by our reproducer through a simple patch:
> stop merging bfq_queues if their parents are different.

Can you please share your reproducer? I have prepared some patches which
I'd like to verify before posting... Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
