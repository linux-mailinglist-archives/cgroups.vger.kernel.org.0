Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E05A8F588A
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2019 21:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfKHUd7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 Nov 2019 15:33:59 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44051 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfKHUd7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 Nov 2019 15:33:59 -0500
Received: by mail-qk1-f193.google.com with SMTP id m16so6442825qki.11;
        Fri, 08 Nov 2019 12:33:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1KDdGme2UpEFnmAhINmNhjFi/nc2G5wHiD2TrUpJv34=;
        b=CunJdFg4BYDI2EEsdh5lxRmT8tBGpq/UrMt4JyZwzmKPhYvlNlUMTQ8HbaxqvapN6F
         CDzClYV4sux3Hr69yN6fT8BQRHPERwDBm0VyUUqj7xVURP00jHwIDnmS1jmbNcanJBZr
         R0f1UsK1rctLjHDTiI4Vza8N3r7Qm/oQvAtc7EdGhgau3x87AM9cCsr9OgfRMbIKwfVp
         cRNSLWhJsjMjtSVSSqwIu81VlbOm6r3DyZuAdEaBN6PMzURJ/HmcVoTOgMOPxch/fhPV
         upox07Xc+yASjEGBQp2x4q2dDRJXApT5SstGsr0nsg7wvR1jTb5gpo1mqzJw9KPdsuHO
         zR/g==
X-Gm-Message-State: APjAAAVLEuJWRCBRWVcGn3ueDj4yzU/1v0+/7/dsdulx7jHdnV1J7fBX
        dgO8oc3XsB0ccTdVZC+AtMY=
X-Google-Smtp-Source: APXvYqxqREgxuQljP90fvsWT+oy5Bd9idOzRJPHjiJXxA/cs0GRieMlRAKmjcPrpKDrr1n2JBBdcxA==
X-Received: by 2002:a37:72c3:: with SMTP id n186mr11217923qkc.166.1573245238017;
        Fri, 08 Nov 2019 12:33:58 -0800 (PST)
Received: from dennisz-mbp ([2620:10d:c091:500::1:ac97])
        by smtp.gmail.com with ESMTPSA id x64sm3263515qkd.88.2019.11.08.12.33.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 12:33:57 -0800 (PST)
Date:   Fri, 8 Nov 2019 15:33:55 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, kernel-team@fb.com,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Dennis Zhou <dennis@kernel.org>
Subject: Re: [PATCH block/for-linus] cgroup,writeback: don't switch wbs
 immediately on dead wbs if the memcg is dead
Message-ID: <20191108203355.GA54333@dennisz-mbp>
References: <20191108201829.GA3728460@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108201829.GA3728460@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 08, 2019 at 12:18:29PM -0800, Tejun Heo wrote:
> cgroup writeback tries to refresh the associated wb immediately if the
> current wb is dead.  This is to avoid keeping issuing IOs on the stale
> wb after memcg - blkcg association has changed (ie. when blkcg got
> disabled / enabled higher up in the hierarchy).
> 
> Unfortunately, the logic gets triggered spuriously on inodes which are
> associated with dead cgroups.  When the logic is triggered on dead
> cgroups, the attempt fails only after doing quite a bit of work
> allocating and initializing a new wb.
> 
> While c3aab9a0bd91 ("mm/filemap.c: don't initiate writeback if mapping
> has no dirty pages") alleviated the issue significantly as it now only
> triggers when the inode has dirty pages.  However, the condition can
> still be triggered before the inode is switched to a different cgroup
> and the logic simply doesn't make sense.
> 
> Skip the immediate switching if the associated memcg is dying.
> 
> This is a simplified version of the following two patches:
> 
>  * https://lore.kernel.org/linux-mm/20190513183053.GA73423@dennisz-mbp/
>  * http://lkml.kernel.org/r/156355839560.2063.5265687291430814589.stgit@buzz
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Fixes: e8a7abf5a5bd ("writeback: disassociate inodes from dying bdi_writebacks")
> ---
>  fs/fs-writeback.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 8461a6322039..335607b8c5c0 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -576,10 +576,13 @@ void wbc_attach_and_unlock_inode(struct writeback_control *wbc,
>  	spin_unlock(&inode->i_lock);
>  
>  	/*
> -	 * A dying wb indicates that the memcg-blkcg mapping has changed
> -	 * and a new wb is already serving the memcg.  Switch immediately.
> +	 * A dying wb indicates that either the blkcg associated with the
> +	 * memcg changed or the associated memcg is dying.  In the first
> +	 * case, a replacement wb should already be available and we should
> +	 * refresh the wb immediately.  In the second case, trying to
> +	 * refresh will keep failing.
>  	 */
> -	if (unlikely(wb_dying(wbc->wb)))
> +	if (unlikely(wb_dying(wbc->wb) && !css_is_dying(wbc->wb->memcg_css)))
>  		inode_switch_wbs(inode, wbc->wb_id);
>  }
>  EXPORT_SYMBOL_GPL(wbc_attach_and_unlock_inode);

Acked-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis
