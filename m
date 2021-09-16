Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7538140E964
	for <lists+cgroups@lfdr.de>; Thu, 16 Sep 2021 20:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244084AbhIPRxu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Sep 2021 13:53:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36968 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245293AbhIPRtG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Sep 2021 13:49:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A0EDC1FF07;
        Thu, 16 Sep 2021 17:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631814456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92sbNZ4wtt7HJbLDVek/qCHTZYn/db8qMt1chWEKSus=;
        b=QxXUahxQZ+eYlKdrdkwUUz1H1yNVburuoAS/zqp9XPPRLN8gqTzaSP8TKq+nMOUsv1RPtE
        CJgaLN5eFXNtCcIu37SJ0qE2IbJMb5GHevpOLPbv9JbhgHPte9kJjt7El4FT0VEvPH76HM
        DPuNlKRa8XTHg9F4I6QYYbHFDgj+iFo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8383F13D5A;
        Thu, 16 Sep 2021 17:47:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2TSRHjiDQ2H1bQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 16 Sep 2021 17:47:36 +0000
Date:   Thu, 16 Sep 2021 19:47:35 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        vipinsh@google.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 3/3] docs/cgroup: add entry for misc.events
Message-ID: <20210916174735.GA12271@blackbody.suse.cz>
References: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631671936.git.brookxu@tencent.com>
 <7cb32b92b77188f50b46bb47eb728bcacf18c17f.1631671936.git.brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7cb32b92b77188f50b46bb47eb728bcacf18c17f.1631671936.git.brookxu@tencent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 15, 2021 at 10:18:51AM +0800, brookxu <brookxu.cn@gmail.com> wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> Added descriptions of misc.events.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Michal Koutný <mkoutny@suse.com>

