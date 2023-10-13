Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4D47C8270
	for <lists+cgroups@lfdr.de>; Fri, 13 Oct 2023 11:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjJMJsX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Oct 2023 05:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjJMJsW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Oct 2023 05:48:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4107195;
        Fri, 13 Oct 2023 02:48:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7116A21891;
        Fri, 13 Oct 2023 09:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697190498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8s6/qratdWv8O4Dy4/uS58AK1dKHHaBtdVRKEao/M/Q=;
        b=j/BTLnCFHL9z6kFmgeEostX33PfEmBYauE4OtLEa0pMvrKCpcJRfGXqxW+JqEzIA9aG5Pu
        w28jbZKnzjoYldDLJqxjij9ZOVLZaod7Kk0WEexLIqVgrWsoLPz9aZ98HVokb5nSmZF7v3
        jxs1M3TZkPPpk52IlLfmOvt65fUeMko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697190498;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8s6/qratdWv8O4Dy4/uS58AK1dKHHaBtdVRKEao/M/Q=;
        b=2VrbrE3DFeg1UP5e3JDjUDtEvgs6W1Vm0mwJ1ZOHBV8/8TfWSUOQYobJIz/sr1DQ0FBB1h
        k6wpcTURLt1lFkDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53DE71358F;
        Fri, 13 Oct 2023 09:48:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vq0oFGISKWXzHQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 13 Oct 2023 09:48:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D75C9A05C4; Fri, 13 Oct 2023 11:48:17 +0200 (CEST)
Date:   Fri, 13 Oct 2023 11:48:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     tj@kernel.org, guro@fb.com, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, cgroups@vger.kernel.org, jack@suse.cz,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v2] writeback, cgroup: switch inodes with dirty
 timestamps to release dying cgwbs
Message-ID: <20231013094817.bm62tq3cjjtgobto@quack3>
References: <20231013055208.15457-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013055208.15457-1-jefflexu@linux.alibaba.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.50
X-Spamd-Result: default: False [-2.50 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_SPAM(5.10)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[13];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 13-10-23 13:52:08, Jingbo Xu wrote:
> The cgwb cleanup routine will try to release the dying cgwb by switching
> the attached inodes.  It fetches the attached inodes from wb->b_attached
> list, omitting the fact that inodes only with dirty timestamps reside in
> wb->b_dirty_time list, which is the case when lazytime is enabled.  This
> causes enormous zombie memory cgroup when lazytime is enabled, as inodes
> with dirty timestamps can not be switched to a live cgwb for a long time.
> 
> It is reasonable not to switch cgwb for inodes with dirty data, as
> otherwise it may break the bandwidth restrictions.  However since the
> writeback of inode metadata is not accounted for, let's also switch
> inodes with dirty timestamps to avoid zombie memory and block cgroups
> when laztytime is enabled.
> 
> Fixs: c22d70a162d3 ("writeback, cgroup: release dying cgwbs by switching attached inodes")
  ^^^ Fixes

> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Otherwise looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v2: add comment explaining why switching for inodes with dirty
> timestamps is needed
> 
> v1: https://lore.kernel.org/all/20231011084228.77615-1-jefflexu@linux.alibaba.com/
> ---
>  fs/fs-writeback.c | 41 +++++++++++++++++++++++++++++------------
>  1 file changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index c1af01b2c42d..1767493dffda 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -613,6 +613,24 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
>  	kfree(isw);
>  }
>  
> +static bool isw_prepare_wbs_switch(struct inode_switch_wbs_context *isw,
> +				   struct list_head *list, int *nr)
> +{
> +	struct inode *inode;
> +
> +	list_for_each_entry(inode, list, i_io_list) {
> +		if (!inode_prepare_wbs_switch(inode, isw->new_wb))
> +			continue;
> +
> +		isw->inodes[*nr] = inode;
> +		(*nr)++;
> +
> +		if (*nr >= WB_MAX_INODES_PER_ISW - 1)
> +			return true;
> +	}
> +	return false;
> +}
> +
>  /**
>   * cleanup_offline_cgwb - detach associated inodes
>   * @wb: target wb
> @@ -625,7 +643,6 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
>  {
>  	struct cgroup_subsys_state *memcg_css;
>  	struct inode_switch_wbs_context *isw;
> -	struct inode *inode;
>  	int nr;
>  	bool restart = false;
>  
> @@ -647,17 +664,17 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
>  
>  	nr = 0;
>  	spin_lock(&wb->list_lock);
> -	list_for_each_entry(inode, &wb->b_attached, i_io_list) {
> -		if (!inode_prepare_wbs_switch(inode, isw->new_wb))
> -			continue;
> -
> -		isw->inodes[nr++] = inode;
> -
> -		if (nr >= WB_MAX_INODES_PER_ISW - 1) {
> -			restart = true;
> -			break;
> -		}
> -	}
> +	/*
> +	 * In addition to the inodes that have completed writeback, also switch
> +	 * cgwbs for those inodes only with dirty timestamps. Otherwise, those
> +	 * inodes won't be written back for a long time when lazytime is
> +	 * enabled, and thus pinning the dying cgwbs. It won't break the
> +	 * bandwidth restrictions, as writeback of inode metadata is not
> +	 * accounted for.
> +	 */
> +	restart = isw_prepare_wbs_switch(isw, &wb->b_attached, &nr);
> +	if (!restart)
> +		restart = isw_prepare_wbs_switch(isw, &wb->b_dirty_time, &nr);
>  	spin_unlock(&wb->list_lock);
>  
>  	/* no attached inodes? bail out */
> -- 
> 2.19.1.6.gb485710b
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
