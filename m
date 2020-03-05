Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1FC117A73C
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2020 15:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgCEOSu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Mar 2020 09:18:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38249 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgCEOSu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Mar 2020 09:18:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id t11so7232518wrw.5;
        Thu, 05 Mar 2020 06:18:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rWJ2ZlSxIkaxSxkCwz25+2vXHAwKGZKzs8QIO832cQQ=;
        b=tH0ci005uLQQ/UHnvPeaL17EVOJawtcI6QorU0/Ssq0k9UjR+9IB5wRzxQcm6rPjVF
         0Rv5dpq/YRL0guHqS1cFHyhg7v5SnRQWFwodkpMK43Ejf4a0TibAtFbWoBcE+wV6Q9F+
         hsJosZh/8AMDDdZsAFBUA584XGbg71KFrDnAIV2JMbcJmSLyDfO2OBvZ1Uc3frZWXfDW
         3uJbWbTEcsMIGAe+0DYD9B8/YL5O0XfQIfNIl8jNmINC5vREo2p0LaPv39vqYVn6MmuY
         Yfjkr9yhpuxD2cd9I6PA+TnbrpT01YvDk5BXkUFTvTgSCWExFsJ5U+flo7OU6xsJEhHv
         eIfA==
X-Gm-Message-State: ANhLgQ0Q4P0mMwUL3u72lgMtEwIJ7PtbcAzu73mdmPrYNgv8Z8I2O5DS
        WNF1c3S7ruU9mr4k3TI+ZPo=
X-Google-Smtp-Source: ADFU+vtH94zikoX75hnruOksDPDvYJmpWPGT2ZWAveIETS75sC34iW1Ksl4YSW8m9d5DeokNkVD9JQ==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr767658wro.193.1583417928448;
        Thu, 05 Mar 2020 06:18:48 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id f17sm24030443wrm.3.2020.03.05.06.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 06:18:47 -0800 (PST)
Date:   Thu, 5 Mar 2020 15:18:45 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: Make mem_cgroup_id_get_many dependent on MMU and
 MEMCG_SWAP
Message-ID: <20200305141845.GZ16139@dhcp22.suse.cz>
References: <20200304142348.48167-1-vincenzo.frascino@arm.com>
 <20200304165336.GO16139@dhcp22.suse.cz>
 <8c489836-b824-184e-7cfe-25e55ab73000@arm.com>
 <20200305100023.GR16139@dhcp22.suse.cz>
 <acf13158-40a3-4027-f36a-25d24efe3242@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acf13158-40a3-4027-f36a-25d24efe3242@arm.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 05-03-20 10:46:21, Vincenzo Frascino wrote:
[...]
> I am aware of this. I was just exploring if there was a possibility of
> addressing the warning, since if we leave all the warnings in scenarios like
> randconfig can cause confusion in between real and non real issues.

I would very much like to address _real_ warnings. This one is just
bugus. I do not see a fix that would be sensible. Wrapping the helper
by ifdefs is just going to make the resulting code worse because there
is nothing really specific to swap there. Marking it __maybe_unused will
just paper over the report and allow the function to bitrot when it is
not used anymore.

So for now I would just live with the warning unless it is really
causing any real problems.

-- 
Michal Hocko
SUSE Labs
