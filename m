Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98493466A9
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2019 19:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfFNR4r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jun 2019 13:56:47 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:34591 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfFNR4r (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jun 2019 13:56:47 -0400
Received: by mail-qk1-f172.google.com with SMTP id t8so2251674qkt.1;
        Fri, 14 Jun 2019 10:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rr4DhL8mkbmYJTu+prptdDL5l4mcP175r2QLE+Qn8CA=;
        b=cLJE6Rf50VcaPIRaV80FOsBwRwK4nUuYdTa5x8SSx7ww6xsZtzmNPaHRzNFTqODvt6
         /hDunowkAFc2MbCFwhosFbE8+tPmvxmQRmpC52XUQF980dU32Z/0oL5rfh3XNrTNYbFv
         KriO0fhfVsUT+A9lhgqJbmINYpztEe4MklT1Ldi/Vti1KUej1yYg4tDVt3hgO+0jTOpz
         5Fj80H6LyQIWI99RhAp20XnOEHvpU96YrUa8/k5wkGWwVitKTO6pO/6rPbClA3iQm2IW
         4fu7vDzS8uvA/oeFzyyU9Ar2Hi+EglXMSWAaTbVT0DVcRnsuLKZdJlnI/97tTg2cJhpu
         KCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rr4DhL8mkbmYJTu+prptdDL5l4mcP175r2QLE+Qn8CA=;
        b=KebvoWhKRM0aSt+WSLpMLhu2XJ8iQgggI0djTeL6CGayR+zWhhhyArkODirBXA3XT+
         0JxXHsU2YcUj9WGIQdWyY7nYQblTZWOGFcBTIpimCbdY6t0qE9rPybXrtpZ0rH5vtL9a
         u1U/sxt2TaaEiEtqgT0s3KfHYo88uWGL3w02Vf0xiZqxa0WcN5rN9fQarnM1LTAcZ5Aa
         aFn9H4ZYS5lMsQtr8BKdfZ0fojQypcZ2JffWDn9UAXwjajhMqqQ54udpBsBRx75NC7sv
         IbfOf7/dMEWIicDBwf20AB9nlKYlu6S0fqqRfgKvqNyiI7CEgmrt2ly6yki1HOFOBLy0
         BgMQ==
X-Gm-Message-State: APjAAAV0RcvJv174bkSSjwvOcofaEdzzM79TnPw6+k4SeFv04xveZcTf
        VeaycOzZ0rD6KAEvJT0CZYU=
X-Google-Smtp-Source: APXvYqyur5VtexgQTx8OWTjFE9G5cpfspjCCJpY9hNeZ4lleSYHrVILXqbnzUXo5x1BF6SWDHMdQ/Q==
X-Received: by 2002:a37:7646:: with SMTP id r67mr57567827qkc.249.1560535005491;
        Fri, 14 Jun 2019 10:56:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::6bab])
        by smtp.gmail.com with ESMTPSA id t187sm1843362qkh.10.2019.06.14.10.56.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 10:56:44 -0700 (PDT)
Date:   Fri, 14 Jun 2019 10:56:42 -0700
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCHSET block/for-next] IO cost model based work-conserving
 porportional controller
Message-ID: <20190614175642.GA657710@devbig004.ftw2.facebook.com>
References: <20190614015620.1587672-1-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614015620.1587672-1-tj@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jun 13, 2019 at 06:56:10PM -0700, Tejun Heo wrote:
...
> The patchset is also available in the following git branch.
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-iow

Updated patchset available in the following branch.  Just build fixes
and cosmetic changes for now.

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-iow-v2

Thanks.

-- 
tejun
