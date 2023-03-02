Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D856A83E4
	for <lists+cgroups@lfdr.de>; Thu,  2 Mar 2023 14:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjCBN6c (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Mar 2023 08:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCBN6a (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Mar 2023 08:58:30 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C551B2F2;
        Thu,  2 Mar 2023 05:58:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EF5DA1FE68;
        Thu,  2 Mar 2023 13:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677765505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m18Gv9KRE3npZc7Xmq0D5vkDDAhP4Hl2wTCDi72SDpo=;
        b=djSO1i5fr7YYbKoXmmYvlQeXd9sPNkcfpe5miqD9fqpAmEyoxgNZBMog929bzxFS9DRAC3
        iKApzkwryC1JfrA1lV3aNa4GhTb8dO8KMALNk0vDJESlGIslpyQnwkbTvmlLak84qHmIwj
        dYeUJwrEXMctnKaLlqcazcflwlFY6Vc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CED4E13A63;
        Thu,  2 Mar 2023 13:58:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JXHnL4GrAGQ9VQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 02 Mar 2023 13:58:25 +0000
Date:   Thu, 2 Mar 2023 14:58:25 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
        peterz@infradead.org, johunt@akamai.com, keescook@chromium.org,
        quic_sudaraja@quicinc.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] psi: remove 500ms min window size limitation for
 triggers
Message-ID: <ZACrgV4f39P/2sZO@dhcp22.suse.cz>
References: <20230301193403.1507484-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301193403.1507484-1-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 01-03-23 11:34:03, Suren Baghdasaryan wrote:
> Current 500ms min window size for psi triggers limits polling interval
> to 50ms to prevent polling threads from using too much cpu bandwidth by
> polling too frequently. However the number of cgroups with triggers is
> unlimited, so this protection can be defeated by creating multiple
> cgroups with psi triggers (triggers in each cgroup are served by a single
> "psimon" kernel thread).
> Instead of limiting min polling period, which also limits the latency of
> psi events, it's better to limit psi trigger creation to authorized users
> only, like we do for system-wide psi triggers (/proc/pressure/* files can
> be written only by processes with CAP_SYS_RESOURCE capability). This also
> makes access rules for cgroup psi files consistent with system-wide ones.
> Add a CAP_SYS_RESOURCE capability check for cgroup psi file writers and
> remove the psi window min size limitation.
> 
> Suggested-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> Link: https://lore.kernel.org/all/cover.1676067791.git.quic_sudaraja@quicinc.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

with this to fix
[...]
> @@ -1278,8 +1277,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
>  	if (state >= PSI_NONIDLE)
>  		return ERR_PTR(-EINVAL);
>  
> -	if (window_us < WINDOW_MIN_US ||
> -		window_us > WINDOW_MAX_US)
> +	if (window_us <= 0 || window_us > WINDOW_MAX_US)
>  		return ERR_PTR(-EINVAL);

window_us is u32 sp the check for <= 0 doesn't make any sense.

>  
>  	/* Check threshold */
> -- 
> 2.40.0.rc0.216.gc4246ad0f0-goog

-- 
Michal Hocko
SUSE Labs
