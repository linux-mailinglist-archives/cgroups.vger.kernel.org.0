Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5C9429379
	for <lists+cgroups@lfdr.de>; Mon, 11 Oct 2021 17:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237749AbhJKPgT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Oct 2021 11:36:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46416 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbhJKPgS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Oct 2021 11:36:18 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0CBEC1FED2;
        Mon, 11 Oct 2021 15:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633966458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZL4FlCU5ckfxXlCQEcdiVJas2l+qPTW/K1inX6vWtpY=;
        b=ZaVEyJ2OYsHCWHcdHtNktV8SP1RE4O5Hm9uc2Y8bLSEQ8tGgVWSeMa9/vwvfVALILKo2ms
        WoTZtyamBomNpEvlr0MrPn3NnsfP0Cm46gvQwuCmllDkGxNsCG+nyP6yKr+Fq1FNHfWTDW
        XylMA3SzpDtokKMxBgtByuYAUWiDlIc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2AE913BCB;
        Mon, 11 Oct 2021 15:34:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SOHWOnlZZGGYVAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 11 Oct 2021 15:34:17 +0000
Date:   Mon, 11 Oct 2021 17:34:16 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Odin Hultgren van der Horst <odin@digitalgarden.no>
Cc:     tj@kernel.org, cgroups@vger.kernel.org
Subject: Re: Re: [Question] io cgroup subsystem threaded support
Message-ID: <20211011153416.GB61605@blackbody.suse.cz>
References: <20211001110645.uzw2w5t4rknwqhma@T580.localdomain>
 <20211007133916.mgk6qb65d2r57fc2@T580.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007133916.mgk6qb65d2r57fc2@T580.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello.

On Thu, Oct 07, 2021 at 03:39:16PM +0200, Odin Hultgren van der Horst <odin@digitalgarden.no> wrote:
> So mainly the writeback functionality or is it ingrained in all
> functionality like latency and priority?

What do you want to achieve actually?

> If not, is there a subset of io cgroup subsys that could easily support threading?

I'd say such a subset would be similar to what can be done with
ioprio_set(2).

Michal
