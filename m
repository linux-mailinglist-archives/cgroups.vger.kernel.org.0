Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4E2F97F8E
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2019 18:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfHUQAl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Aug 2019 12:00:41 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44857 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfHUQAl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Aug 2019 12:00:41 -0400
Received: by mail-qk1-f194.google.com with SMTP id d79so2244259qke.11;
        Wed, 21 Aug 2019 09:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SkQ1iRQmedFusEhYknXF0m0szFVCfve43ayyHL3P7UE=;
        b=PfRGf7dJmGlq/vFV6Y+jNfBdQj9FXFXpgr4U2sqHZkOOzikZqcKARWfm/Ay9cjoDSU
         SCX+h5EJLGStrV2y6/OzsiFWSydoRDIB8xs/LthT66NJMLZAYtyRP5nrnZgOEeHiNyJk
         1bf35F88LlY3ZL6xZzCIEGGOZVVSZr2saC2AonVkeLUBSZKclxcjROkdE6IhiIiZK18A
         z1eW4eMKnZKE5uALGEnUQyOrqFkSKIT6AjOY4D73Eu6oZ+ZkI6UO+7WVtIvPOc7iPQV5
         aAxUr8psXAumVPPm2Vln5wKADn3tcXCg2XrJ+MksLKbdQw0SqjF2hpb4xY0Ud7EO5OH2
         B8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SkQ1iRQmedFusEhYknXF0m0szFVCfve43ayyHL3P7UE=;
        b=c0tISbAsv4wpwue6Ehj1RzHwKDpIYuLEDDM8VbXDdYoOBuJCo5q7H0TIVLJIlc4WNe
         BoWIusBC5VCoKrxKYjh81yFZka2Oq5+tIJO4F/piwde1KsOPZiy2QyC78IgfgM1fD9pS
         PwhC7Ikw+cOGMh/MiFyzFya8f/DY8JFpFRH0Jkyy+5MT8RSfJNHfWBG2bp2koNiXwmhK
         eQ0EJmHACi5xn6FH98JxzrYmxduiqx4vD15SJhDLM6prs5mLjrR6vz9qxGV9RkALq2hZ
         /x+emHSjeWeTrfilRP6dGpAuEZufZh1T+1SlBQoTWvR9w3hL+9O6N7ub8af/0BDbY+9v
         +jhg==
X-Gm-Message-State: APjAAAUE1x9Lv27kfbcKbfQ1P9q8zY6waEW8B21OEl+E2hc9cBarXxy1
        XE6BCJKaxx7AltntHhC7TRs=
X-Google-Smtp-Source: APXvYqygD4G25/4+1lbrU9OJUBtreiUUAzC3687HWTZ5HRPAeIzC0XOf19SJJBxuWv+Hi3cQWG/YHA==
X-Received: by 2002:a37:395:: with SMTP id 143mr32776745qkd.317.1566403240448;
        Wed, 21 Aug 2019 09:00:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:1f05])
        by smtp.gmail.com with ESMTPSA id s58sm11388981qth.59.2019.08.21.09.00.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 09:00:39 -0700 (PDT)
Date:   Wed, 21 Aug 2019 09:00:37 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     axboe@kernel.dk, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, guro@fb.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH 5/5] writeback, memcg: Implement foreign dirty flushing
Message-ID: <20190821160037.GK2263813@devbig004.ftw2.facebook.com>
References: <20190815195619.GA2263813@devbig004.ftw2.facebook.com>
 <20190815195930.GF2263813@devbig004.ftw2.facebook.com>
 <20190816160256.GI3041@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816160256.GI3041@quack2.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Aug 16, 2019 at 06:02:56PM +0200, Jan Kara wrote:
> 1) You ask to writeback LONG_MAX pages. That means that you give up any
> livelock avoidance for the flusher work and you can writeback almost
> forever if someone is busily dirtying pages in the wb. I think you need to
> pick something like amount of dirty pages in the given wb (that would have
> to be fetched after everything is looked up) or just some arbitrary
> reasonably small constant like 1024 (but then I guess there's no guarantee
> stuck memcg will make any progress and you've invalidated the frn entry
> here).

I see.  Yeah, I think the right thing to do would be feeding the
number of dirty pages or limiting it to one full sweep.  I'll look
into it.

> 2) When you invalidate frn entry here by writing 0 to 'at', it's likely to get
> reused soon. Possibly while the writeback is still running. And then you
> won't start any writeback for the new entry because of the
> atomic_read(&frn->done.cnt) == 1 check. This seems like it could happen
> pretty frequently?

Hmm... yeah, the clearing might not make sense.  I'll remove that.

Thanks.

-- 
tejun
