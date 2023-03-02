Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988E26A8802
	for <lists+cgroups@lfdr.de>; Thu,  2 Mar 2023 18:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjCBRlv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Mar 2023 12:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjCBRlu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Mar 2023 12:41:50 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7769627D75;
        Thu,  2 Mar 2023 09:41:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 263AA220A4;
        Thu,  2 Mar 2023 17:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677778908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BxNVxQxpUa9EQo7tVoxpRgg3ciw7b1eHgoO8lDNIC4g=;
        b=sRSXGveL2AxhYFLe9CL6gEeYCvl9WiMlJb1JB6ba2xNlKm3NIYjul+j63hydUrBXrBsWH8
        jS4XB5rta541t3pGOeXW3wZVJBd6ZnvYmZXdTfeYKZPmKyo8ILT8HZ9LH7OqGsOCPzKPs2
        h704ERv8SZ/bl/SRJYsneFT5PXFiT9E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 00A9513349;
        Thu,  2 Mar 2023 17:41:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id erg4OdvfAGRQTgAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 02 Mar 2023 17:41:47 +0000
Date:   Thu, 2 Mar 2023 18:41:47 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, tj@kernel.org,
        lizefan.x@bytedance.com, peterz@infradead.org, johunt@akamai.com,
        keescook@chromium.org, quic_sudaraja@quicinc.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] psi: remove 500ms min window size limitation for
 triggers
Message-ID: <ZADf27Kx5mbFev+I@dhcp22.suse.cz>
References: <20230301193403.1507484-1-surenb@google.com>
 <Y/+wlg5L8A1iebya@cmpxchg.org>
 <CAJuCfpHhA4XpoE96u5CPktDcSChUkQG_Ax58NzJOiOoF2K+3qQ@mail.gmail.com>
 <ZADBCEk68W1aGJAV@cmpxchg.org>
 <CAJuCfpHF=9Dv_Yzph5jNmR1ZfTf7Lf=_oShztyLUq0ps_D=osQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHF=9Dv_Yzph5jNmR1ZfTf7Lf=_oShztyLUq0ps_D=osQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 02-03-23 08:13:54, Suren Baghdasaryan wrote:
[...]
> Let's roll this check without additional changes and then consolidate
> the checking inside psi_trigger_create() in a separate patch. If
> anybody objects to the late permission check we will just revert that
> last change without affecting anything else.

Permissions checks at write time are problematic because userspace
cannot drop privileges. Also I think it would be an antipattern for how
we do this in general. 
-- 
Michal Hocko
SUSE Labs
