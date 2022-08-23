Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB36959E601
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 17:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243237AbiHWP3F (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 11:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243281AbiHWP2s (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 11:28:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB774B6D5C
        for <cgroups@vger.kernel.org>; Tue, 23 Aug 2022 04:10:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 60752220F4;
        Tue, 23 Aug 2022 11:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661252973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2XVveNc1dHKejESI2gGQJL+VnYAV4gj0L8ylbdECtpU=;
        b=FCeUQ724pTy5Ea3UaRF/6QIFB0gNQebplremp8YmoiQtbvkk3JFJpQTyZb4IDGzAmfzwYd
        glZ2/gyZ3iKvIwVJo0Wv4J2X8FqP6meHgI24VemtlvrP33XuPt/xJ+kWyynTYgAmgeJ80l
        AGmLH6z/HDaiEiVa8h7eN0q8URQU40U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 305F413A89;
        Tue, 23 Aug 2022 11:09:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P2TgCm21BGOcIwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 23 Aug 2022 11:09:33 +0000
Date:   Tue, 23 Aug 2022 13:09:31 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] cgroup: simplify cleanup in cgroup_css_set_fork()
Message-ID: <20220823110931.GB1729@blackbody.suse.cz>
References: <20220823091147.846082-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220823091147.846082-1-brauner@kernel.org>
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

Hello.

On Tue, Aug 23, 2022 at 11:11:47AM +0200, Christian Brauner <brauner@kernel.org> wrote:
>  kernel/cgroup/cgroup.c | 2 --
>  1 file changed, 2 deletions(-)

Sensible cleanup,
Reviewed-by: Michal Koutný <mkoutny@suse.com>
