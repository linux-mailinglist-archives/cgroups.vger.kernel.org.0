Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9D319D392
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2019 17:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbfHZP6j (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Aug 2019 11:58:39 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38923 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731198AbfHZP6i (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Aug 2019 11:58:38 -0400
Received: by mail-qk1-f193.google.com with SMTP id 125so14425541qkl.6;
        Mon, 26 Aug 2019 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ualaw3vnF7au6b9X5hx4CHQJfw3fBI27o57pEiUgbJo=;
        b=GnZUYkQ4vVP/v3mu6UxwHdso20ta7Q+KhSdq+8YuwnxdWNjaUmry5GKa9icK1tWcPe
         i/Pa4V+XigAXejuiA1uK/adIfsd3tDcx7eNQWCvIoM7+QHoz4QqAu7XMNSgL7N8+zqdE
         Ok9jG1XQ3c//jnZbPEfKOODlmHb3a7fgG1xvkLv2WSTgnTZ0rDXfwKvAOEvY1x+5qNmd
         pm1xCF4GvRicJfJDbO+EIuu1fTxJrTXW/dSfkGdSesws3Z7Jjp9PFSy+eyS5KifycqKL
         eHHWeEryOX/9dFa/d+Z/gnxpRShYwQ/t30umzlPd2vtUN8mYXy8+GKymvgk7N/3qzv5V
         v2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ualaw3vnF7au6b9X5hx4CHQJfw3fBI27o57pEiUgbJo=;
        b=e2ySka08Sez80MxvhYdLYkkn7TQ7Y238qZNwmyfcZLP5tbevcNJFFwLEpwE3J0IpiR
         2DTRiqRnVVLqDTS+1nwGml2rFV/m30iENh1TjweZZ92AW7lo/fktHvhhlz1EGfIQau3p
         62zN4wTI07M8v5bvtWMJai87Nsz0855WUEH/HG6leaz9y8nVpsyCihUO/xMjEK/IfxWD
         AzOJXrufBdb8QfLAuDAE5s4c9nFyIW97aZs6pow0u4sX6VpNk3g0kAZWUTDwpC94xgJm
         wBp0eJnXgpplPGT9KkleSQ/vWX9rmtNCC1++hgrOwpz6TjxP4xF6AnJnT0oQUQ3lKNaY
         RmaA==
X-Gm-Message-State: APjAAAWR8ncIxrunHX3oQhLM9DzupYLg0aaHqpJ7ejoxD9oua/rXW++Z
        kx7e5c7Pk5UtiaA9fMjacl4=
X-Google-Smtp-Source: APXvYqzk/P1DVpjgy0hFgeWPetp0WfMSK+IUiMif/29MeRJwYBpNW0Jt/njmIG/Lg9zleKegbXPjwA==
X-Received: by 2002:a37:6290:: with SMTP id w138mr16091986qkb.139.1566835117260;
        Mon, 26 Aug 2019 08:58:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::d081])
        by smtp.gmail.com with ESMTPSA id y25sm7676497qkj.35.2019.08.26.08.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 08:58:36 -0700 (PDT)
Date:   Mon, 26 Aug 2019 08:58:34 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     axboe@kernel.dk, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, guro@fb.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH v3 5/5] writeback, memcg: Implement foreign dirty flushing
Message-ID: <20190826155834.GP2263813@devbig004.ftw2.facebook.com>
References: <20190815195619.GA2263813@devbig004.ftw2.facebook.com>
 <20190815195930.GF2263813@devbig004.ftw2.facebook.com>
 <20190821210235.GN2263813@devbig004.ftw2.facebook.com>
 <20190826135452.GF10614@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826135452.GF10614@quack2.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Jan.

On Mon, Aug 26, 2019 at 03:54:52PM +0200, Jan Kara wrote:
> As I've checked, you should be using get_jiffies_64() to get value of
> jiffies_64. Also for comparisons of jiffie values, I think you should be
> using time_after64() and similar functions instead of direct comparisons...

Yeah, good point.  I always forget that with jiffies_64.  Will post an
updated series soon.

Thanks.

-- 
tejun
