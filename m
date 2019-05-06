Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8F6150A0
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2019 17:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfEFPsE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 May 2019 11:48:04 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38436 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbfEFPsE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 May 2019 11:48:04 -0400
Received: by mail-qk1-f194.google.com with SMTP id a64so2292580qkg.5;
        Mon, 06 May 2019 08:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LX6YFWpOFyks9hyOivtdYrKQenlUglNUVGne6XsM9M8=;
        b=CcTqdCliUeE1ZYvoBYOEJ0tHDuAM5vOzp2XWkvoudqqDauRGuQ+VCS/BmYqplP1ndW
         i1wkCyGAvyzC7WufXiQ4woED+t+TgUCIezlUm1qA1nJx/fdUuBMeJw+gGzdmvg73MT2a
         42Ff0r4lhGXsEdeBJ1OXv3WHSQ9cL1UfXyqmWFv+5RXoOBlB2OXbnQJLhd2aGnDE6nB4
         LmZDtsbylXhtLp3kxLQvYMlYpzScLiUNCMdfmffR67fy2Q88moE94mJ2f+JO7aRaIMA6
         ocjxZwY6kNGefZA7Q+qJfAqU5NKzBGsjnUOsC74SALI1+3jg8BAiDv6o2YrOegZFFAe9
         k6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LX6YFWpOFyks9hyOivtdYrKQenlUglNUVGne6XsM9M8=;
        b=i38eB1JOaCZ+JhBOsZ1ptZOoxFIbZPujiZhi/sTlLnW9nrKvOTG9nHQ31j5jbyaWLr
         vcbIkV0K3NJqQIryuf4IJZIz/kj4Vp1qMPmexiTgdDhFv8DyWfzJ0XCj5pz0YqUsiXvf
         YuxYvaOjITD+6eRLraaJ/x1YE6sqNOSmw1Igh2qBrBda1YTlz4mqh7LskcU7gdsjC9Sr
         S3dvzsdJ868/2xc3oXQntltbAaAY33iL3R64tNvPxwDIfavNwOvCX7KIAj/hza7EZtA8
         6YGXyRe/CD2VnyZiLRx5o6kN57wVGxbqWMCj4WoyZxkizwowL0NmHybXb+VaCxn+G9/q
         u8WA==
X-Gm-Message-State: APjAAAUctOhbmOB2ZQmFe+tFXr4W+C2Yqi/tPq2Lqz6PSc1Nw9y9P6Ve
        hABlJKmTUgdF5l6a7CiriCY=
X-Google-Smtp-Source: APXvYqxk2h8Nf4qrQDOT7UCSHjhjuRCeZZxEw1Vh/zwEx0cV7zYkna6LSWqOqRMkhQ2SB7cDULfICQ==
X-Received: by 2002:ae9:d844:: with SMTP id u65mr19191907qkf.310.1557157683318;
        Mon, 06 May 2019 08:48:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:34f3])
        by smtp.gmail.com with ESMTPSA id 33sm5967726qtg.94.2019.05.06.08.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 08:48:02 -0700 (PDT)
Date:   Mon, 6 May 2019 08:48:00 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/06] kernel: cgroup: fix misuse of %x
Message-ID: <20190506154800.GT374014@devbig004.ftw2.facebook.com>
References: <20190421114727.20325-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190421114727.20325-1-huangfq.daxian@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Apr 21, 2019 at 07:47:27PM +0800, Fuqian Huang wrote:
> Pointers should be printed with %p or %px rather than
> cast to unsigned long type and printed with %lx.
> Change %lx to %p to print the pointers.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>

Applied to cgroup/for-5.2.

Thanks.

-- 
tejun
