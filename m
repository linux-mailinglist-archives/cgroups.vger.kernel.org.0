Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B0A52489F
	for <lists+cgroups@lfdr.de>; Thu, 12 May 2022 11:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351865AbiELJLX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 May 2022 05:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351904AbiELJLT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 May 2022 05:11:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E2F2EA08
        for <cgroups@vger.kernel.org>; Thu, 12 May 2022 02:11:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 876661F8F4;
        Thu, 12 May 2022 09:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652346675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fZGQ/vOR7gCkfyiu8i5HUwuHnaGqSWUWPuuLMrnW1vc=;
        b=LDxw38MEZfmzD+EtDUv1t93Y8YoJWLOHk+Eu4JFrfa9EGfepnpJ9EJHfZ0A65xQkqiJaN2
        26TaOHuYxBoiGZPGYK7fdj4HeNMiFiSeP1xJ5yQx4DebxKyQ67/5EhHpigDizkgnhx2NWi
        Oo7tRoCFfRpQG+GClWS1D5LXPsbUI30=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E5C513A84;
        Thu, 12 May 2022 09:11:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bQIiFjPPfGIsLQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 12 May 2022 09:11:15 +0000
Date:   Thu, 12 May 2022 11:11:13 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Ganesan Rajagopal <rganesan@arista.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/memcontrol: Export memcg->watermark via sysfs for
 v2 memcg
Message-ID: <20220512091113.GB5536@blackbody.suse.cz>
References: <20220507050916.GA13577@us192.sjc.aristanetworks.com>
 <20220511174953.GC31592@blackbody.suse.cz>
 <CAPD3tpG_mDq+zpKnFTKgWCuW9_wCfsHMu2ndzOEBsLaqZp-KWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPD3tpG_mDq+zpKnFTKgWCuW9_wCfsHMu2ndzOEBsLaqZp-KWA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 12, 2022 at 08:18:01AM +0530, Ganesan Rajagopal <rganesan@arista.com> wrote:
> Good point. The patch has already been picked up for mm-unstable.

Oh, I didn't notice that.

> I don't know what's the process in this situation. Should I post a
> "[PATCH v3]" with an updated commit message?

Or you can send a fixup for folding? (I see this is something new,
you better ask Andrew.)

Michal
