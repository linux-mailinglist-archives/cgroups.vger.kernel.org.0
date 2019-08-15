Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C45438F039
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2019 18:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbfHOQMP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Aug 2019 12:12:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42095 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729151AbfHOQMP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Aug 2019 12:12:15 -0400
Received: by mail-qt1-f194.google.com with SMTP id t12so2870936qtp.9;
        Thu, 15 Aug 2019 09:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iTIKIuhQjFmLzffUqNs0d7EM6m2UJCFz471NWYlW/kA=;
        b=QXjkEAHzvaI4d+a1jTu1uuBdBcwkiUcidF6xSV/xQKF2N7ucXBCF5Hej38FIPF0Lm3
         9fWE+N6hf68OLIhzBONo5J5LQOEGzbqPKECQp+aEdwFdT+opMpMJ1qGxqzQD9gdQCPEz
         IecizOukDzYwhTyD2KWejogmiAgKaK1vXPLIaF4L9biBH+TFPKprcr2WQ/6fGoTrK2rx
         p6Un0uytpeqSTUTd8k+dvepjTTMJOAFXt4wObsUiZTFbAJFHR3q+4a3Y/b8ZvK/foXDm
         wpA60ZcOdP6GWCrYCNX13gHb4P/T2mGkfQelkmBGCL+lGa6+8NnbqBd7hYAfkgZPkPEV
         CS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iTIKIuhQjFmLzffUqNs0d7EM6m2UJCFz471NWYlW/kA=;
        b=DshGSZyBDDUsy6n0MdXUVPNma+jMuvlxlFrUV5h7A9AeJz9Nevh/ZRjX1hRnWsoQqH
         IVWDB/OOyqs4n6nDeuPap1i8UtdE2uYP+dLnKlQ1Xr441meYWrUunrkQWVpAfLuCRCik
         ysGyKelbR2Np/zJErNvm+FlR+Hcmd4XHpR/TRH42oSODMXVfblXvsi9HB5bSndgKjmha
         50lydEXjH0Z0psxIc2rcs4qwha8eQN0v0sbzHigXyDe0dP8FCz3VHOpUwSMtcJ+F8Uh3
         QU7OzYGkmU63aNRi2LO7hsLy4uEvEqp8R6koRceXbbZjFCYSk2rkt8Abf13ht5NHCfbZ
         hQUQ==
X-Gm-Message-State: APjAAAVjqL2yviom4OtbQgwb1fO41o+JVXMkiLziG0MbPcXRrU1+WCEW
        n4uFlrdt8aMdJhR77Ppp2DI=
X-Google-Smtp-Source: APXvYqyI+etnk5089VErOMk8XqgTxfwAkSptHHANrHUw1yrHJeZLiH5w0UkWbcFYiSOmm16KjfaZlA==
X-Received: by 2002:ac8:6b8f:: with SMTP id z15mr4797796qts.62.1565885534276;
        Thu, 15 Aug 2019 09:12:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:25cd])
        by smtp.gmail.com with ESMTPSA id a21sm1430581qtj.5.2019.08.15.09.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 09:12:13 -0700 (PDT)
Date:   Thu, 15 Aug 2019 09:12:11 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     axboe@kernel.dk, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, guro@fb.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH 3/4] writeback, memcg: Implement cgroup_writeback_by_id()
Message-ID: <20190815161211.GC588936@devbig004.ftw2.facebook.com>
References: <20190803140155.181190-1-tj@kernel.org>
 <20190803140155.181190-4-tj@kernel.org>
 <20190815145421.GN14313@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815145421.GN14313@quack2.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 15, 2019 at 04:54:21PM +0200, Jan Kara wrote:
> > +	/* and find the associated wb */
> > +	wb = wb_get_create(bdi, memcg_css, GFP_NOWAIT | __GFP_NOWARN);
> > +	if (!wb) {
> > +		ret = -ENOMEM;
> > +		goto out_css_put;
> > +	}
> 
> One more thought: You don't want the "_create" part here, do you? If
> there's any point in writing back using this wb, it must be attached to
> some inode and thus it must exist. In the normal case wb_get_create() will
> just fetch the reference and be done with it but when you feed garbage into
> this function due to id going stale or frn structures getting corrupted due
> to concurrent access, you can be creating bogus wb structures in bdi...

Yeah, it can create wbs unnecessarily which isn't critical but also is
easy to fix.  Will update.

Thanks.

-- 
tejun
