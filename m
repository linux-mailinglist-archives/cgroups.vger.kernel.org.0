Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34C6405930
	for <lists+cgroups@lfdr.de>; Thu,  9 Sep 2021 16:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240915AbhIIOif (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Sep 2021 10:38:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42710 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243634AbhIIOiW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Sep 2021 10:38:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9C1181FE0D;
        Thu,  9 Sep 2021 14:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631198231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B13u36Po4th2PuCEKGfMkrGfL3GxX63/1jwqx05ECVY=;
        b=rzmaYDhYG5qnwQA/AoM96BOvbbRiPT5ow5w4NWsIMzyC/qCkdSV04NKUjqShHai0jwl5Lu
        P0p7dna95aJJtXGORVvI/Mm6X7gp6dVNTcpPs86fJmhxNXO356fn0MEROIaHBgkuWAFYIN
        RMKpLOWT6ngoKabiOmsB2f1GUB5Rd+4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7324D13C53;
        Thu,  9 Sep 2021 14:37:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Y+/VGhccOmHVOwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 09 Sep 2021 14:37:11 +0000
Date:   Thu, 9 Sep 2021 16:37:10 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        vipinsh@google.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] misc_cgroup: introduce misc.failcnt for V1
Message-ID: <20210909143709.GA14603@blackbody.suse.cz>
References: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
 <c4e091c8c0208554b97f751ae80a093f55f19883.1631077837.git.brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4e091c8c0208554b97f751ae80a093f55f19883.1631077837.git.brookxu@tencent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 08, 2021 at 01:24:35PM +0800, brookxu <brookxu.cn@gmail.com> wrote:
> introduce misc.failcnt for cgroup v1 to make it easier for us to
> understand the pressure of resources.

As argued in the patch 1/3, I'd drop this change completely.

Thanks,
Michal
