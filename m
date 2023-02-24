Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779A36A1DEF
	for <lists+cgroups@lfdr.de>; Fri, 24 Feb 2023 16:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBXPCk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Feb 2023 10:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjBXPCk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Feb 2023 10:02:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F01E658C9;
        Fri, 24 Feb 2023 07:02:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B687038DA5;
        Fri, 24 Feb 2023 15:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677250954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d8dUNJuoGh57MMmzf6vnneijK9db4lzSQ6GQgUgsF7U=;
        b=e0Z/9wOiQZhXeUoLx2DGZ2kkdRJLjS9c5vrTd6UXnvd476+j6OMnwKPIDdR8+uqppgl/5O
        EdRvXfTAZ3+4SjAAQkBtZYIuWi8h7axrtS+rXX7YqXHthFEssSxO+zInHdiG/mJB7JeexV
        4NOeApm8s4f4SgLYujPd9+YHf6EFwGI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D93213A3A;
        Fri, 24 Feb 2023 15:02:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8xkpG4rR+GM1fwAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 24 Feb 2023 15:02:34 +0000
Date:   Fri, 24 Feb 2023 16:02:33 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Matthew Chae <matthewc@axis.com>
Cc:     Matthew Chae <Matthew.Chae@axis.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel <kernel@axis.com>,
        Christopher Wong <Christopher.Wong@axis.com>,
        Muchun Song <muchun.song@linux.dev>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/memcontrol: add memory.peak in cgroup root
Message-ID: <Y/jRibeqSlO1Z55I@dhcp22.suse.cz>
References: <AM5PR0202MB25167BFBBE892630A2EE3B7DE1AB9@AM5PR0202MB2516.eurprd02.prod.outlook.com>
 <Y/eizTVo8LM70flh@P9FQF9L96D.corp.robot.car>
 <AM5PR0202MB2516BD45CFBC033F9EA3B0A4E1AB9@AM5PR0202MB2516.eurprd02.prod.outlook.com>
 <Y/h0GlmeSQ735DxK@dhcp22.suse.cz>
 <df9cc4e1-befc-af10-c353-733bec54baf1@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df9cc4e1-befc-af10-c353-733bec54baf1@axis.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URI_DOTEDU autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 24-02-23 15:18:49, Matthew Chae wrote:
> Hi Michal
> 
> Thank you for helping me gain full insight.
> It looks like there is no proper way to get the peak memory usage recorded
> without adding any overhead to the system and for all users. But I fully
> understand what you kindly explained. Basically, having low memory left
> doesn't mean a bad situation for the system, So checking the peak memory
> doesn't mean a lot and is not necessary.

You might find https://www.pdl.cmu.edu/ftp/NVM/tmo_asplos22.pdf
interesting and helpful
-- 
Michal Hocko
SUSE Labs
